# frozen_string_literal: true

# For running bank transactions
class Transaction
  attr_reader :account
  attr_accessor :balance, :credit, :debit, :account

  def initialize (balance = 0, credit = 0, debit = 0, date = Time.now.strftime('%d/%m/%Y'))
    @account = []
    @balance = balance
    @credit = credit
    @debit = debit
    @date = date
  end

  def modify_balance(amount)
    error_handler(amount)
  end

  def deposit(amount = 0)
    error_handler(amount)
    @credit = amount
    @balance += credit
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
