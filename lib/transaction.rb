class Transaction
  attr_reader :account
  attr_writer :date, :credit, :debit, :balance

  def initialize
    @account = [['date || credit || debit || balance']]
    @date = Time.now.strftime("%d/%m/%Y")
    @credit = @debit = @balance = 0
  end

  def deposit(amount)
    @credit = amount
    @balance += @credit
    @line = ["#{@date} || #{@credit} || || #{@balance}"]
    @account.push(@line)
  end

  def withdraw(amount)
    @debit = amount
    @balance -= @debit
    @line = ["#{@date} || || #{@debit} || #{@balance}"]
    @account.push(@line)
  end
end
