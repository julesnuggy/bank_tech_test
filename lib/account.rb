# frozen_string_literal: true
require 'Transaction'

# Controls account activity
class Account
  attr_accessor :balance

  def initialize(balance = 0)
    @account = []
    @balance = balance
  end

  def deposit(amount)
    request_transaction(amount, :credit)
  end

  def withdraw(amount)
    request_transaction(amount, :debit)
  end

  private

  def request_transaction(amount, type, transaction_class = Transaction)
    transaction = transaction_class.new(type)
    @balance = transaction.modify_balance(amount)
  end

end
