# frozen_string_literal: true

# Controls account activity
class Account
  attr_reader :balance

  def initialize(balance = 0, transaction_class = Transaction)
    @transaction_class = transaction_class
    @account = []
    @balance = balance
  end

  def deposit(amount, type = :credit)
    error_handler(amount, type)
    request_transaction(amount, type)
  end

  def withdraw(amount, type = :debit)
    error_handler(amount, type)
    request_transaction(amount, type)
  end

  private

  def request_transaction(amount, type)
    transaction = @transaction_class.new(type, balance)
    @balance = transaction.modify_balance(amount)
  end

  def error_handler(amount, type)
    raise 'Not a number' unless amount.is_a? Numeric
    raise 'Negative number' unless amount.positive?
    raise 'Insufficient balance' unless type == :credit || amount <= balance
  end
end
