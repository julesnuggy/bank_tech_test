# frozen_string_literal: true

require_relative '../lib/account.rb'

describe Account do
  let(:fake_statement_class) { double('fake_statement_class') }
  let(:fake_statement) { double('fake_statement') }

  let(:fake_transaction_class) { double('fake_transaction_class') }
  let(:fake_transaction) { double('fake_transaction') }

  subject(:account) { described_class.new(1000, fake_transaction_class, fake_statement_class) }

  before(:each) do
    allow(fake_statement_class).to receive(:new).and_return(fake_statement)
  end

  context 'when a #deposit is made' do
    before(:each) do
      # Arrange
      allow(fake_transaction_class).to receive(:new).with(
        fake_statement, :credit, account.balance
      ).and_return(fake_transaction)
      allow(fake_transaction).to receive(:record_transaction)
    end

    it 'should increase the balance (via public method)' do
      # Action
      expect(fake_transaction).to receive(:modify_balance).and_return(1500)
      account.deposit(500)
      # Assert
      expect(account.balance).to eq(1500)
    end

    it 'should increase the balance (via private method)' do
      allow(fake_transaction).to receive(:modify_balance).with(500).and_return(1500)
      # Action
      account.send :request_transaction, 500, :credit
      # Assert
      expect(account.balance).to eq(1500)
    end
  end

  context 'when a #withdrawal is made' do
    before(:each) do
      # Arrange
      allow(fake_transaction_class).to receive(:new).with(
        fake_statement, :debit, account.balance
      ).and_return(fake_transaction)
      allow(fake_transaction).to receive(:record_transaction)
    end

    it 'should decrease the balance (via public method)' do
      # Action
      expect(fake_transaction).to receive(:modify_balance).and_return(800)
      account.withdraw(200)
      # Assert
      expect(account.balance).to eq(800)
    end

    it 'should decrease the balance (via private method)' do
      allow(fake_transaction).to receive(:modify_balance).and_return(800)
      # Action
      account.send :request_transaction, 200, :debit
      # Assert
      expect(account.balance).to eq(800)
    end
  end

  context 'when an invalid amount is provided' do
    it 'should return an error for non-numeric deposits' do
      expect { account.deposit('x') }.to raise_error('Not a number')
    end

    it 'should return an error for non-numeric withdrawals' do
      expect { account.withdraw('x') }.to raise_error('Not a number')
    end

    it 'should return an error for negative number deposits' do
      expect { account.deposit(-10.12) }.to raise_error('Negative number')
    end

    it 'should return an error for negative number withdrawals' do
      expect { account.withdraw(-10.12) }.to raise_error('Negative number')
    end

    it 'should return an error for insufficient balance' do
      expect { account.withdraw(1000.01) }.to raise_error('Insufficient balance')
    end
  end

  context 'when a print statement request is made' do
    before(:each) do
      # Arrange
      allow(fake_transaction_class).to receive(:new).with(
        fake_statement, :credit, account.balance
      ).and_return(fake_transaction)
      allow(fake_transaction).to receive(:record_transaction)
    end

    it 'displays a list of all transactions that have happened to date' do
      # Arrange
      report = <<~EXPECTED
        date || credit || debit || balance
        21/04/2018 || 250 || || 750
        20/04/2018 || || 500 || 500
        19/04/2018 || 1000 || 1000
        EXPECTED
      # Action
      expect(fake_statement).to receive(:generate_report).and_return(report)
      # Assert
      expect { account.print_statement }.to output(report).to_stdout
    end
  end
end
