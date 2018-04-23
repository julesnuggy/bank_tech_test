# frozen_string_literal: true

require_relative '../lib/transaction.rb'

describe Transaction do
  let(:transaction) do
    described_class.new
  end

  context 'when an invalid amount is provided' do
    it 'should raise an error if amount is not a number' do
      expect { transaction.deposit('x') }.to
      raise_error('Please enter an integer')
    end

    it 'should raise an error if amount is a negative number' do
      expect { transaction.deposit(-10) }.to
      raise_error('Please enter a positive number')
    end
  end
end
