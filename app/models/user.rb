class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  include DeviseInvitable::Inviter

  has_many :float_plans, dependent: :destroy

  validates :phone_number,
            format: { with: /\d{3}-?\d{3}-?\d{4}/, message: I18n.t('phone_number_error') }
  validates_presence_of :name

  def owner_of?(record)
    id == record.user_id
  end
end
