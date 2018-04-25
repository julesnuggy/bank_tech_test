# frozen_string_literal: true

# Gets the date in the specified format
class Date
  attr_reader :date

  def initialize(date = Time.now)
    @date = date.strftime('%d/%m/%Y')
  end
end
