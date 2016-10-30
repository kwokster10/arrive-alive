class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :assign_user, except: [:index]

  def index
    @title = t('users.index')
    @users = policy_scope(User)
  end

  def show
    @title = t('users.show', user_name: @user.name)
  end

  def edit
    @title = t('users.edit', user_name: @user.name)
  end

  def update
    if @user.update_attributes(permitted_attributes(@user))
      redirect_to @user
    else
      flash.now[:alert] = @user.errors.full_messages.join('. ')
      @title = t('users.edit', user_name: @user.name)
      render :edit
    end
  end

  private

  def assign_user
    @user = User.find(params[:id])
    authorize @user
  end
end
