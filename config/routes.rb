Rails.application.routes.draw do
  get 'wellcome/index'
  resources :posts
  root 'welcome#index'
end
