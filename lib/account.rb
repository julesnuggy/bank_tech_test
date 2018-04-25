# frozen_string_literal: true

# Controls account activity
class Account
  attr_reader :balance, :statement

  def initialize(balance = 0, transaction_class = Transaction,
                 statement_class = Statement)
    @balance = balance
    @transaction_class = transaction_class
    @statement = statement_class.new
  end

  def deposit(amount)
    error_handler(amount, :credit)
    request_transaction(amount, :credit)
  end

  def withdraw(amount)
    error_handler(amount, :debit)
    request_transaction(amount, :debit)
  end

  def print_statement
    puts statement.generate_report
  end

  private

  def request_transaction(amount, type)
    transaction = @transaction_class.new(statement, type, balance)
    @balance = transaction.modify_balance(amount)
    transaction.record_transaction
    balance
  end

  def error_handler(amount, type)
    raise 'Not a number' unless amount.is_a? Numeric
    raise 'Negative number' unless amount.positive?
    raise 'Insufficient balance' unless type == :credit || amount <= balance
  end
end
