Rails.application.routes.draw do
  get 'wellcome/index'
  resources :posts do
    resources :comments
  end
  root 'welcome#index'
end
