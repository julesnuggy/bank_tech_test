# frozen_string_literal: true

require_relative '../lib/transaction.rb'

describe Transaction do
  subject(:credit_transaction) { described_class.new(:credit) }
  subject(:debit_transaction) { described_class.new(:debit, 1000) }

  it 'should increase the calc_balance for a credit transaction' do
    # Action
    credit_transaction.modify_balance(500)
    # Assert
    expect(credit_transaction.calc_balance).to equal(500)
  end

  it 'should decrease the calc_balance for a debit transaction' do
    # Action
    debit_transaction.modify_balance(200)
    # Assert
    expect(debit_transaction.calc_balance).to equal(800)
  end

end
