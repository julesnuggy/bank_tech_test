require_relative '../lib/account.rb'

describe Account do
  let(:fake_transaction_class) { double('fake_transaction_class') }
  let(:fake_transaction) { double('fake_transaction') }
  subject(:account) { described_class.new(1000) }

  context 'when a deposit is made' do

    it 'should increase the balance (via public method)' do
      # Arrange
      # Action
      # Assert
      # expect(fake_transaction).to receive(:modify_balance)
    end

    it 'should increase the balance (via private method)' do
      # Arrange
      allow(fake_transaction_class).to receive(:new).with(:credit).and_return(fake_transaction)
      allow(fake_transaction).to receive(:modify_balance).and_return(1500)
      # Action
      account.send :request_transaction, "500", :credit, fake_transaction_class
      # Assert
      expect(account.balance).to equal(1500)
    end
  end

  it 'should decrease the balance when a withdrawal is made' do
    # Arrange
    allow(fake_transaction_class).to receive(:new).with(:debit).and_return(fake_transaction)
    allow(fake_transaction).to receive(:modify_balance).and_return(800)
    # Action
    account.send :request_transaction, "200", :debit, fake_transaction_class
    # Assert
    expect(account.balance).to equal(800)
  end

end
