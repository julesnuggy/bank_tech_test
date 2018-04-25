# frozen_string_literal: true

# Executes account statement operations
class Statement
  attr_reader :transaction_report, :transaction_history, :transaction_record,
              :date, :credit, :debit, :balance

  def initialize
    @transaction_history = []
  end

  def record(transaction, date = Date.new.date)
    @transaction_record = { date: nil, credit: nil, debit: nil, balance: nil }
    @date = date
    @transaction_record[:date] = date
    @transaction_record[:credit] = transaction.calc_amount if
                                   transaction.type == :credit
    @transaction_record[:debit] = transaction.calc_amount if
                                  transaction.type == :debit
    @transaction_record[:balance] = transaction.calc_balance
    @transaction_history.unshift(transaction_record.dup)
  end

  def generate_report
    @transaction_report = "date || credit || debit || balance\n"
    transaction_history.each do |record|
      @transaction_report +=
        "#{record[:date]} || #{record[:credit]} || #{record[:debit]} || #{record[:balance]}\n"
      @transaction_report.gsub!(/  /, ' ')
    end
    transaction_report
  end
end
