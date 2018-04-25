# frozen_string_literal: true

require_relative '../lib/transaction.rb'

describe Transaction do
  let(:fake_statement) { double('fake_statement') }

  subject(:credit_transaction) { described_class.new(fake_statement, :credit) }
  subject(:debit_transaction) { described_class.new(fake_statement, :debit, 1000) }
  subject(:transaction_to_record) { described_class.new(fake_statement, :credit, 1000, 100) }

  context 'a credit transaction' do
    it 'should increase the calc_balance' do
      # Action
      credit_transaction.modify_balance(500)
      # Assert
      expect(credit_transaction.calc_balance).to equal(500)
    end

    it 'should be able to accept decimal numbers' do
      # Action
      credit_transaction.modify_balance(88.13)
      # Assert
      expect(credit_transaction.calc_balance).to equal(88.13)
    end

    it 'should return a number rounded to 2 decimal places' do
      # Arrange
      credit_transaction.modify_balance(11.11)
      # Action
      expect_balance = credit_transaction.modify_balance(11.15)
      # Assert
      expect(expect_balance).to eq(22.26)
    end
  end

  context 'a debit transaction' do
    it 'should decrease the calc_balance' do
      # Action
      debit_transaction.modify_balance(200)
      # Assert
      expect(debit_transaction.calc_balance).to equal(800)
    end

    it 'should be able to accept decimal numbers' do
      # Action
      debit_transaction.modify_balance(50.13)
      # Assert
      expect(debit_transaction.calc_balance).to equal(949.87)
    end
  end

  context 'recording a transaction' do
    # Fake object which Statement would return when #record is run
    let(:fake_statement_record_transaction) do
      {
        date: '21/04/2018',
        credit: 100,
        debit: nil,
        balance: 1000
      }
    end

    it 'should return a record of the transaction' do
      # Arrange
      allow(fake_statement).to receive(:record).and_return(fake_statement_record_transaction)
      # Action
      transaction_to_record.record_transaction
      # Assert
      expect(transaction_to_record.recorded_transaction).to eq(
        date: '21/04/2018',
        credit: 100,
        debit: nil,
        balance: 1000
      )
    end
  end
end
