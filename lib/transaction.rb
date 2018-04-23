# frozen_string_literal: true

# For running bank transactions
class Transaction
  attr_reader :account

  def initialize
    @account = []
    @date = Time.now.strftime('%d/%m/%Y')
    @credit = @debit = @balance = 0
  end

  def deposit(amount)
    @credit = amount
    @balance += @credit
    @line = ["#{@date} || #{@credit} || || #{@balance}"]
    @account.unshift(@line)
  end

  def withdraw(amount)
    @debit = amount
    @balance -= @debit
    @line = ["#{@date} || || #{@debit} || #{@balance}"]
    @account.unshift(@line)
  end
end
