class FloatPlansController < ApplicationController
  before_action :authenticate_user!

  def index
    @title = t('float_plans.index')
    @float_plans = policy_scope(FloatPlan)
  end

  def new
    @title = t('float_plans.new')
    @float_plan = FloatPlan.new(
      start_time: Time.now,
      arrival_time: Time.now + 4.hours,
      state: 0)
  end

  def show
    @float_plan = FloatPlan.find(params[:id])
    authorize @float_plan
    @title = t('float_plans.show', float_plan_name: @float_plan.name)
  end

  def create
    @float_plan = FloatPlan.create(create_params)
  end

  def edit
    @float_plan = FloatPlan.find(params[:id])
    authorize @float_plan
    @title = t('float_plans.edit', float_plan_name: @float_plan.name)
  end

  def update
    binding.pry
    @float_plan = FloatPlan.find(params[:id])
    authorize @float_plan
    if @float_plan.update_attributes(permitted_attributes(@float_plan))
      redirect_to @float_plan
    else
      render :index, :alert => t('not_allowed')
    end
  end
end
