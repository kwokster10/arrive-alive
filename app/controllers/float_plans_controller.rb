class FloatPlansController < ApplicationController
  before_action :authenticate_user!

  def index
    #TODO: scope to a user
    @float_plans = FloatPlan.all
  end

  def new
    @title = t('float_plans.new')
    @float_plan = FloatPlan.new(
      start_time: Time.now,
      arrival_time: Time.now + 4.hours,
      state: 0)
  end

  def create
    @float_plan = FloatPlan.create()
  end

  private
  def new_params
    params.require(:float_plan).permit(:name, :start_time, :arrival_time, :start_location, :arrival_location, :boat_number, :email, :phone_number, :participants, :direction_of_sail, :current, :had_vhf_radio, :had_three_flares, :had_throw_rope, :had_checked_weather, :state)
  end

  def update_status_params
    params.require(:float_plan).permit(:status)
  end
end
