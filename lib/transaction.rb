# frozen_string_literal: true

# For running bank transactions
class Transaction
  attr_reader :account

  def initialize
    @account = []
    @date = Time.now.strftime('%d/%m/%Y')
    @credit = @debit = @balance = 0
  end

  def deposit(amount = 0)
    error_handler(amount)
    @credit = amount
    @balance += @credit
    @line = ["#{@date} || #{@credit} || || #{@balance}"]
    @account.unshift(@line)
  end

  def withdraw(amount = 0)
    error_handler(amount)
    @debit = amount
    @balance -= @debit
    @line = ["#{@date} || || #{@debit} || #{@balance}"]
    @account.unshift(@line)
  end

  def error_handler(amount)
    raise ArgumentError, 'Please enter a number (e.g. 200, 11.23)' unless (amount.is_a? Numeric)
    raise ArgumentError, 'Please enter a positive number' if amount.negative?
  end
end
