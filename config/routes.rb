Rails.application.routes.draw do
  # routes for devise users
  devise_for :users, :skip => [:registrations]
  devise_scope :user do
    get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
    put 'users' => 'devise/registrations#update', :as => 'user_registration'
    # root of site
    root 'devise/sessions#new'
  end

  resources :float_plans
end
