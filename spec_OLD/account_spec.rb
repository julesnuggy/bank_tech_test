# require_relative '../lib/account.rb'
#
# describe Account do
#   let(:fake_transaction) do
#     double('fake_transaction', balance: 0)
#   end
#
#   let(:fake_transaction_deposit) do
#     double('fake_transaction', credit: 100)
#   end
#
#   let(:fake_statement) do
#     double('fake_statement')
#   end
#
#   let(:account) do
#     described_class.new
#   end
#
#   it 'should have an updated @balance when a deposit occurs' do
#     allow(account).to receive(fake_transaction_deposit)
#     expect(account.balance).to equal(100)
#   end
# end
