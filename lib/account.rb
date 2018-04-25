# frozen_string_literal: true
require 'transaction'
require 'statement'
# Controls account activity
class Account
  attr_reader :balance

  def initialize(balance = 0, transaction_class = Transaction, statement_class = Statement)
    @balance = balance
    @transaction_class = transaction_class
    @statement_class = statement_class
  end

  def deposit(amount)
    error_handler(amount, :credit)
    request_transaction(amount, :credit)
  end

  def withdraw(amount)
    error_handler(amount, :debit)
    request_transaction(amount, :debit)
  end

  private

  def request_transaction(amount, type)
    statement = @statement_class.new
    transaction = @transaction_class.new(statement, type, balance)
    @balance = transaction.modify_balance(amount)
  end

  def error_handler(amount, type)
    raise 'Not a number' unless amount.is_a? Numeric
    raise 'Negative number' unless amount.positive?
    raise 'Insufficient balance' unless type == :credit || amount <= balance
  end
end
