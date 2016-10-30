class FloatPlan < ActiveRecord::Base
  belongs_to :user

  enum state: {started: 0, arrived: 1, cancelled: 2, distressed: 3}
  default_scope { order(:state, updated_at: :desc) }

  BOAT_NUMBERS = [2, 8, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26]
  LOCATIONS = %w@North\ Cove LLM@

  validates :current, inclusion: {in: %w(ebb flood), message: I18n.t('float_plans.errors.current')}
  validates :start_location, :arrival_location, inclusion: {in: LOCATIONS, message: I18n.t('float_plans.errors.locations')}
  validate :check_start_end_locations
  validates :phone_number, format: { with: /\d{3}-\d{3}-\d{4}/, message: I18n.t('phone_number_error') }
  validate :more_than_two_members, on: :create

  before_validation :format_participants
  before_create :append_date_to_name

  # FloatPlan.where(state: :started)

  private

  def check_start_end_locations
    errors.add(:arrival_location, I18n.t('float_plans.errors.arrival_location')) unless start_location == arrival_location
  end

  def more_than_two_members
    if participants.present? && participants.select{|p| p['is_member'] && p['name'].present? }.count < 2
      errors.add(:participants, I18n.t('float_plans.errors.participants'))
    end
  end

  def append_date_to_name
    name.prepend("#{DateTime.now.strftime('%m/%d/%Y')} ")
  end

  def format_participants
    participants.each do |obj|
      obj['name'] = obj['name'].strip.downcase.titleize if obj['name']
      obj['is_member'] = obj['is_member'] == 'true'
    end
  end
end
