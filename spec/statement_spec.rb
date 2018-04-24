# frozen_string_literal: true

require_relative '../lib/statement.rb'

describe Statement do
  let(:credit_transaction) { double('credit_transaction', type: :credit, calc_amount: 100, calc_balance: 100) }
  let(:statement) { described_class.new() }

  it 'records each transaction that takes place' do
    statement.record(credit_transaction, '21/04/2018')
    expect(statement.transaction_record).to eq( {
        date: '21/04/2018',
        credit: 100,
        debit: nil,
        balance: 100
      }
    )
  end

end
