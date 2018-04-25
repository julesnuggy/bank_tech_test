# frozen_string_literal: true

# Manages account history
class Statement
  attr_reader :transaction_record, :date, :credit, :debit, :balance

  def initialize
    @transaction_record = {
      date: date,
      credit: credit,
      debit: debit,
      balance: balance
    }
  end

  def record(transaction, date = Date.new.date)
    @date = date
    @transaction_record[:date] = date
    @transaction_record[:credit] = transaction.calc_amount if
                                   transaction.type == :credit
    @transaction_record[:debit] = transaction.calc_amount if
                                  transaction.type == :debit
    @transaction_record[:balance] = transaction.calc_balance
    transaction_record
  end
end
