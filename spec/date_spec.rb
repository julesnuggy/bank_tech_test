require_relative '../lib/date.rb'

describe Date do
  let(:fake_date) { double('date', date: '24/04/2018')}
  subject(:date) { described_class.new(fake_date)}

  it 'should return the date in dd/mm/yyyy format' do
    expect(date).to equal('24/04/2018')
  end
end
