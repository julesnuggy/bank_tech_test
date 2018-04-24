require_relative '../lib/account.rb'

describe Account do
  let(:account) { described_class.new(1000) }
  let(:fake_transaction_class) { double('fake_transaction_class') }
  let(:fake_transaction) { double('fake_transaction') }

  before(:each) do

  end

  it 'should increase the balance when a deposit is made' do
    # Arrange
    allow(fake_transaction_class).to receive(:new).with(:credit).and_return(fake_transaction)
    allow(fake_transaction).to receive(:modify_balance).and_return(1500)
    # Action
    account.deposit(500, fake_transaction_class)
    # Assert
    expect(account.balance).to equal(1500)
  end

  it 'should decrease the balance when a withdrawal is made' do
    # Arrange
    allow(fake_transaction_class).to receive(:new).with(:debit).and_return(fake_transaction)
    allow(fake_transaction).to receive(:modify_balance).and_return(800)
    # Action
    account.withdraw(200, fake_transaction_class)
    # Assert
    expect(account.balance).to equal(800)
  end

end
