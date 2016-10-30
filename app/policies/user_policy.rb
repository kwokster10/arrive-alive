class UserPolicy < ApplicationPolicy
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.where.not(id: user.id)
    end
  end

  def index?
    user.admin?
  end

  def show?
    admin_or_owner?
  end

  def update?
    admin_or_owner?
  end

  def edit?
    admin_or_owner?
  end

  def all_attributes_except_admin
    [:name, :email, :phone_number, :password, :password_confirmation]
  end

  def permitted_attributes_for_update
    user.admin? ? all_attributes_except_admin << :admin : all_attributes_except_admin
  end

  private

  def admin_or_owner?
    user.admin? || (record === user)
  end
end
