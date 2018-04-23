class Statement
  attr_reader :transaction, :account

  def initialize(transaction)
    @account = transaction.account
  end

  def print
    @account.unshift(["date || credit || debit || balance"])
    @account.each { |tr|
      puts tr[0].to_s
    }

  end
end
