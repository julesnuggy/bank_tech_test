require_relative '../lib/account.rb'

describe Account do
  let(:fake_transaction) do
    double('fake_transaction', balance: 0)
  end

  let(:fake_statement) do
    double('fake_statement')
  end

  let(:account) do
    described_class.new(fake_transaction, fake_statement)
  end

  it 'should have an updated @balance when a transaction occurs' do
    
  end
end
