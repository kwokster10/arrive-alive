class FloatPlanMailer < ActionMailer::Base
  default to: Proc.new { User.where(admin: true).pluck(:email) }

  def notify_state_change(old_state, float_plan)
    # notify all admin each time a change happens
    @old_state = old_state
    @float_plan = float_plan

    mail(subject: "#{@float_plan.name} - #{@float_plan.state}")
  end

  def notify_damage(float_plan, photo)
    @float_plan = float_plan
    attachments["#{photo.original_filename}"] = File.read(photo.path)

    mail(subject: "Boat # #{@float_plan.boat_number}")
  end
end
