Rails.application.routes.draw do
  # root of site
  root 'float_plans#index'

  # routes for devise users
  devise_for :users, :skip => [:registrations]
  devise_scope :user do
    get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
    put 'users' => 'devise/registrations#update', :as => 'user_registration'
  end

  resources :float_plans
  resources :users, except: [:create, :new]
end
