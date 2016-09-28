module FloatPlanHelper
  def yes_or_no(float_plan, method_string)
    float_plan.send(method_string) ? "#{method_string.humanize}: Y" : "#{method_string.humanize}: N"
  end

  def button_helper(float_plan, text, *args)
    state_map = {
      'Arrived' => [1, 'success'],
      'Cancel' => [2, 'secondary'],
      'Help!' => [3, 'alert']
    }

    capture do
      form_for float_plan do |f|
        concat f.hidden_field :state, value: state_map[text][0]
        concat f.submit text, class: "button #{state_map[text][1]} #{args.join(' ')}"
      end
    end
  end
end
