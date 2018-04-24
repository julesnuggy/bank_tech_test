# frozen_string_literal: true
require 'Transaction'

# Controls account activity
class Account
  attr_accessor :balance

  def initialize(balance = 0)
    @account = []
    @balance = balance
  end

  def deposit(amount, transaction_class = Transaction)
    transaction = transaction_class.new(:credit)
    @balance = transaction.modify_balance(amount)
  end

  def withdraw(amount, transaction_class = Transaction)
    transaction = transaction_class.new(:debit)
    @balance = transaction.modify_balance(amount)
  end

end
