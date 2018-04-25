# frozen_string_literal: true

# Manages account statement activities
class Statement
  attr_reader :transaction_report, :transaction_history, :transaction_record,
              :date, :credit, :debit, :balance

  def initialize
    @transaction_history = []
    @transaction_report = ''
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
    transaction_history.each { |record|
      @transaction_report += "#{record[:date]} || #{record[:credit]} || #{record[:debit]} || #{record[:balance]}\n"
      @transaction_report.gsub!(/  /, ' ')
    }
    transaction_report
  end
end
