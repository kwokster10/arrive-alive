module UserHelper
  def admin_button_helper(user)
    capture do
      form_for user do |f|
        concat f.hidden_field :admin, value: true
        concat f.submit text, class: 'button full-width',
                        data: {confirm: t('users.to_admin', user_name: user.name)}
      end
    end
  end
end
