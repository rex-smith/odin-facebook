Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root "posts#index"

  get '/profile/:id', to: 'users#show', as: :profile

  resources :users, except: [:new, :create]

  resources :users do 
    resources :posts, only: [:index]
    # resources :requests, only: [:index]
  end

  resources :comments, only: [:new, :create, :destroy]
  resources :posts, except: [:edit, :update]
  resources :likes, only: [:create, :destroy] 
  resources :friendships, only: [:index, :create, :destroy]
  resources :requests, only: [:create, :index] do
    member do
      post 'confirm'
      delete 'delete'
    end
  end

  get 'people', to: 'users#people', as: 'people'
  
end
