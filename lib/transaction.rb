# frozen_string_literal: true

# Executes transactions on the account
class Transaction
  attr_accessor :type, :calc_balance
  
  def initialize(type, calc_balance = 0)
    @type = type
    @calc_balance = calc_balance
  end

  def modify_balance(amount)
    if type == :credit
      @calc_balance += amount
    elsif type == :debit
      @calc_balance -= amount
    end
  end
end
