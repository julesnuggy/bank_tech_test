# frozen_string_literal: true

# Executes transactions on the account
class Transaction
  attr_reader :type, :calc_balance, :calc_amount,
              :this_transaction, :recorded_transaction

  def initialize(statement, type, calc_balance = 0, calc_amount = 0)
    @statement = statement
    @type = type
    @calc_balance = calc_balance
    @calc_amount = calc_amount
    @this_transaction = { type: type, calc_amount: calc_amount,
                          calc_balance: calc_balance }
  end

  def modify_balance(amount)
    @calc_amount = amount
    if type == :credit
      (@calc_balance += calc_amount).round(2)
    elsif type == :debit
      (@calc_balance -= calc_amount).round(2)
    end
  end

  def record_transaction(transaction = this_transaction)
    @recorded_transaction = @statement.record(transaction)
  end
end
