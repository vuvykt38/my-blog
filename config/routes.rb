Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  resources :posts do
    resources :comments, only: [:create, :destroy] do
      member do
        # update, edit, destroy
        post :reply
      end

      collection do
        # create, index
      end
    end
  end

  resources :profiles, only: [:show, :edit, :update]
  resources :relationships, only: [:create] do
    collection do
      post :unfollow
    end
  end

  resources :notifications, only: [:index]

  resources :profiles do
    member do
      get :following
      get :followers
    end
  end

  resources :games, only: [:show] do
    member do
      post :move
    end
  end

  root 'posts#index'
end
