module FloatPlanHelper
  def yes_or_no(float_plan, method_string)
    float_plan.send(method_string) ? "#{method_string.humanize}: Y" : "#{method_string.humanize}: N"
  end

  def state_button_helper(float_plan, text)
    state_map = {
      'Mark as Arrived' => [1, 'success'],
      'Cancel Trip' => [2, 'secondary'],
      'Call for Help!' => [3, 'alert']
    }

    capture do
      form_for float_plan do |f|
        concat f.hidden_field :state, value: state_map[text][0]
        concat f.submit text, class: "button full-width #{state_map[text][1]}",
                        data: {confirm: t("float_plans.#{state_map[text][1]}")}
      end
    end
  end

  def save_button_helper(f)
    if current_user.admin?
      f.submit 'Save', class: 'button'
    else
      f.submit 'Save', class: 'button', data: {confirm: t('float_plans.create_confirmation')}
    end
  end
end
