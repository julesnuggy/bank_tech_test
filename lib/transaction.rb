# frozen_string_literal: true

# Executes transactions on the account
class Transaction
  attr_reader :type, :calc_balance, :calc_amount

  def initialize(type, calc_balance = 0)
    @type = type
    @calc_balance = calc_balance
    @calc_amount = 0
  end

  def modify_balance(amount)
    @calc_amount = amount
    if type == :credit
      @calc_balance += calc_amount
    elsif type == :debit
      @calc_balance -= calc_amount
    end
  end
end
