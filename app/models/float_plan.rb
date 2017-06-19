class FloatPlan < ActiveRecord::Base
  default_scope { order(created_at: :desc) }

  belongs_to :user

  enum state: {started: 0, arrived: 1, cancelled: 2, distressed: 3}
  default_scope { order(:state, updated_at: :desc) }

  BOAT_NUMBERS = (1..12).map{|i| i}

  validates :current, inclusion: {in: %w(ebb flood), message: I18n.t('float_plans.errors.current')}
  validates :phone_number, format: { with: /\d{3}-?\d{3}-?\d{4}/, message: I18n.t('phone_number_error') }
  validate :more_than_two_members, on: :create

  before_validation :format_participants

  private

  def more_than_two_members
    if participants.present? && participants.select{|p| p['is_member'] && p['name'].present? }.count < 2
      errors.add(:participants, I18n.t('float_plans.errors.participants'))
    end
  end

  def format_participants
    participants.each do |obj|
      obj['name'] = obj['name'].strip.downcase.titleize if obj['name']
      obj['is_member'] = obj['is_member'] == 'true' || obj['is_member']
    end
  end
end
