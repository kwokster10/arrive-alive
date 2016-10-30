class FloatPlanPolicy < ApplicationPolicy
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user.admin?
        scope.all
      else
        user.float_plans
      end
    end
  end

  def new?
    user.admin? || user.owner_of?(record) || record.new_record?
  end

  def update?
    user.admin? || (user.owner_of?(record) && (record.started? || record.distressed?))
  end

  def edit?
    user.admin?
  end

  def all_attributes_except_notes
    [:name, :start_time, :arrival_time, :start_location, :arrival_location, :boat_number, :email, :phone_number, :direction_of_sail, :current, :had_vhf_radio, :had_three_flares, :had_throw_rope, :had_checked_weather, :user_id]
  end

  def permitted_attributes_for_create
    user.admin? ? all_attributes_except_notes << :notes : all_attributes_except_notes
  end

  def permitted_attributes_for_update
    if user.admin?
      permitted_attributes_for_create
    elsif user.owner_of?(record)
      [:state, :notes]
    end
  end
end
