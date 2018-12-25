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

  resources :notifications, only: [:index, :show]

  resources :profiles do
    member do
      get :following
      get :followers
    end
  end

  resources :games, only: [:show, :index] do
    member do
      post :join
      post :move
    end

    resources :messages, only: [:index, :create] do
    end
  end

  resources :conversations, only: [:index, :show] do
    resources :private_messages, only: [:create]
  end

  root 'posts#index'
end
