class FloatPlansController < ApplicationController
  before_action :authenticate_user!
  before_action :assign_float_plan, only: [:show, :edit, :update]
  before_action :load_float_plan_and_user, only: :send_note

  def index
    @title = t('float_plans.index')
    @float_plans = policy_scope(FloatPlan)
    # TODO: add logic to filter states
  end

  def new
    @title = t('float_plans.new')
    @float_plan = build_new_float_plan
    authorize @float_plan
  end

  def show
    @title = t('float_plans.show', float_plan_name: @float_plan.name)
  end

  def create
    @float_plan = FloatPlan.new
    @float_plan.assign_attributes(formatted_permitted_params)
    if @float_plan.save
      redirect_to float_plan_path @float_plan
    else
      @title = t('float_plans.new')
      flash.now[:alert] = @float_plan.errors.full_messages.join('. ')
      render action: :new
    end
  end

  def edit
    @title = t("float_plans.#{current_user.admin? ?  'edit' : 'notes'}", float_plan_name: @float_plan.name)
  end

  def send_note
    @float_plan.update_attributes(permitted_attributes(@float_plan))

    FloatPlanMailer.notify_damage(@float_plan, params[:photo]).deliver_now

    redirect_to float_plan_path @float_plan
  end

  def update
    old_state = @float_plan.state
    if @float_plan.update_attributes(formatted_permitted_params)
      notify_admin(old_state, @float_plan) if old_state != @float_plan.state

      if @float_plan.arrived? && !current_user.admin?
        redirect_to edit_float_plan_path @float_plan
      else
        redirect_to float_plan_path @float_plan
      end
    else
      @title = t('float_plans.edit', float_plan_name: @float_plan.name)
      flash.now[:alert] = @float_plan.errors.full_messages.join('. ')
      render :edit
    end
  end

  private

  def assign_float_plan
    @float_plan = FloatPlan.find(params[:id])
    authorize @float_plan
  end

  def load_float_plan_and_user
    @float_plan = FloatPlan.includes(:user).find(params[:id])
    authorize @float_plan
  end

  def build_new_float_plan
    float_plan = FloatPlan.new(
      state: 0,
      name: "#{current_user.name} #{DateTime.now.in_time_zone.strftime('%-m/%-d/%Y %l%p')}",
      email: current_user.email,
      phone_number: current_user.phone_number,
      user_id: current_user.id,
      participants: [
        {
          name: current_user.name,
          is_member: true
        },
        {
          name: '',
          is_member: true
        }
      ].to_json
    )

    if query_float_plan_attributes
      float_plan.attributes = query_float_plan_attributes
    end

    float_plan
  end

  def query_float_plan_attributes
    if params[:query].present? && (old_float_plan = FloatPlan.find(params[:query]))
      old_float_plan ? old_float_plan.attributes.extract!('email', 'phone_number', 'participants', 'user_id') : {}
    end
  end

  def formatted_permitted_params
    permitted_attributes(@float_plan).merge(participants_from_params).merge(state_from_params)
  end

  def state_from_params
    params[:float_plan][:state].present? ? {state: params[:float_plan][:state].to_i} : {}
  end

  def participants_from_params
    params[:float_plan][:participants].present? ? {participants: params[:float_plan][:participants].values.select { |obj| obj.keys.length > 1 }.to_json} : {}
  end

  def notify_admin(old_state, float_plan)
    FloatPlanMailer.notify_state_change(old_state, float_plan).deliver_now
  end
end
