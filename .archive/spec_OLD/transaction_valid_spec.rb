# frozen_string_literal: true

require_relative '../lib/transaction.rb'

describe Transaction do
  let(:fake_date) do
    double('fake_date', date: '23/04/2018')
  end

  let(:transaction) do
    described_class.new(fake_date)
  end

  context 'when a valid amount is provided' do
    it 'should allow you to #deposit a credited amount to the account' do
      transaction.deposit(500)
      expect(transaction.account).to include(["#{fake_date} || 500 || || 500"])
    end

    it 'should allow you to #withdraw a debited amount from the account' do
      transaction.withdraw(200)
      expect(transaction.account).to include(["#{fake_date} || || 200 || -200"])
    end

    it 'should add lines to the account array sequentially' do
      transaction.deposit(500)
      transaction.withdraw(200)
      transaction.deposit(250)
      expect(transaction.account).to eq([["#{fake_date} || 250 || || 550"],
                                         ["#{fake_date} || || 200 || 300"],
                                         ["#{fake_date} || 500 || || 500"]])
    end
  end
end
