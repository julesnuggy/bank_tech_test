require_relative '../lib/transaction.rb'

describe 'Transaction' do
  it '#deposit should credit an amount to the account' do
    transaction = Transaction.new
    transaction.deposit(500)
    expect(transaction.account).to include(["23/04/2018 || 500 || || 500"])
  end
end
