require_relative '../lib/transaction.rb'

describe 'Transaction' do
  before(:each) do
    @transaction = Transaction.new
  end

  it 'should allow you to #deposit a credited amount to the account' do
    @transaction.deposit(500)
    expect(@transaction.account).to include(["23/04/2018 || 500 || || 500"])
  end

  it 'should allow you to #withdraw a debited amount from the account' do
    @transaction.withdraw(200)
    expect(@transaction.account).to include(["23/04/2018 || || 200 || -200"])
  end

  it 'should add lines to the account array sequentially' do
    @transaction.deposit(500)
    @transaction.withdraw(200)
    expect(@transaction.account).to include(['date || credit || debit || balance'],
      ["23/04/2018 || 500 || || 500"], ["23/04/2018 || || 200 || 300"])
  end

end
