Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  resources :posts do
    resources :comments
  end

  resources :profiles, only: [:show, :edit, :update]

  root 'posts#index'
end
