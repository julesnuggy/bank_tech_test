require_relative '../lib/date.rb'

describe Date do
  let(:fake_date) { double('fake_date', date: Time.new(2018, 04, 24))}
  subject(:date_instance) { described_class.new(fake_date.date)}

  it 'should return the date in dd/mm/yyyy format' do
    allow(fake_date).to receive(:strftime)
    expect(date_instance.date).to eq('24/04/2018')
  end
end
