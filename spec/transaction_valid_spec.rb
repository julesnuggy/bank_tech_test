# frozen_string_literal: true

require_relative '../lib/transaction.rb'

describe Transaction do
  subject(:credit_transaction) { described_class.new(:credit) }
  subject(:debit_transaction) { described_class.new(:debit, 1000) }

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
end
