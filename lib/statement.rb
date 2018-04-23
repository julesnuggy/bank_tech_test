# frozen_string_literal: true

# For printing account statements
class Statement
  attr_reader :account

  def initialize(transaction)
    @account = transaction.account
  end

  def print
    @account.unshift(['date || credit || debit || balance'])
    @account.each do |tr|
      puts tr[0].to_s
    end
  end
end
