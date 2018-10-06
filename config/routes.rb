Rails.application.routes.draw do
  get 'wellcome/index'

  root 'welcome#index'
end
