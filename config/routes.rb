Rails.application.routes.draw do
  devise_for :users
  get 'wellcome/index'
  resources :posts do
    resources :comments
  end
  root 'welcome#index'
end
