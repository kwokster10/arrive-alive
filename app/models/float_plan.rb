class FloatPlan < ActiveRecord::Base
  belongs_to :user

  enum state: { started: 0, arrived: 1, cancelled: 2, distressed: 3 }

  BOAT_NUMBERS = [2, 8, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26]
  LOCATIONS = %w@North\ Cove LLM@

  before_create :append_date_to_name

  private

  def append_date_to_name
    name.prepend("#{DateTime.now.strftime('%m/%d/%Y')} ")
  end
end
