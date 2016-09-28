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
        scope.where(user_id: user.id)
      end
    end
  end

  def index?

  end

  def update?
    user.admin? || (user.owner_of?(post) && (post.state == 0 || post.state == 3))
  end

  def edit?
    user.admin? || (user.owner_of?(post) && (post.state == 0 || post.state == 3))
  end

  def all_attributes_except_notes
    [:name, :start_time, :arrival_time, :start_location, :arrival_location, :boat_number, :email, :phone_number, :participants, :direction_of_sail, :current, :had_vhf_radio, :had_three_flares, :had_throw_rope, :had_checked_weather, :state]
  end

  def permitted_attributes_for_create
    user.admin? ? all_attributes_except_notes << :notes : all_attributes_except_notes
  end

  def permitted_attributes_for_update
    if user.admin?
      permitted_attributes_for_create
    elsif user.owner_of?(post)
      [:state, :notes]
    end
  end
end
