# frozen_string_literal: true
# 
# require_relative '../lib/statement.rb'
#
# describe Statement do
#   let(:fake_transaction) do
#     double('fake_transaction', account: [['21/04/2018 || 250 || || 750'],
#                                          ['20/04/2018 || || 500 || 500'],
#                                          ['19/04/2018 || 1000 || 1000']])
#   end
#
#   let(:statement) do
#     described_class.new(fake_transaction)
#   end
#
#   it 'should #print all transactions, with the newest at the top' do
#     exp = <<~EXPECTED
#       date || credit || debit || balance
#       21/04/2018 || 250 || || 750
#       20/04/2018 || || 500 || 500
#       19/04/2018 || 1000 || 1000
#       EXPECTED
#     expect { statement.print }.to output(exp).to_stdout
#   end
# end
