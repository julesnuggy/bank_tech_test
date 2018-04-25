# frozen_string_literal: true

require_relative '../lib/statement.rb'

describe Statement do
  let(:credit_transaction) { double('credit_transaction', type: :credit, calc_amount: 100, calc_balance: 100) }
  let(:debit_transaction) { double('credit_transaction', type: :debit, calc_amount: 50, calc_balance: 50) }
  let(:statement) { described_class.new }

  context 'recording a transaction' do
    before(:each) do
      statement.record(credit_transaction, '21/04/2018')
    end

    it 'records a transaction when it takes place' do
      expect(statement.transaction_record).to eq({
        date: '21/04/2018',
        credit: 100,
        debit: nil,
        balance: 100
      })
    end

    it 'saves that transaction to the history' do
      statement.record(debit_transaction, '22/04/2018')
      expect(statement.transaction_history).to eq([{
        date: '22/04/2018',
        credit: nil,
        debit: 50,
        balance: 50
      }, {
        date: '21/04/2018',
        credit: 100,
        debit: nil,
        balance: 100
      }])
    end

  end
  it 'generates a statement report of all transactions' do

  end
end
