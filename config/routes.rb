Rails.application.routes.draw do
  devise_for :users

  root "posts#index"

  get '/profile/:id', to: 'users#show', as: :profile

  resources :users, except: [:new, :create]

  resources :users do 
    resources :posts, only: [:index]
    resources :friendships, only: [:index, :create, :destroy]
    resources :requests, only: [:index, :create, :destroy]
  end

  resources :comments, only: [:new, :create, :destroy]
  resources :posts, except: [:edit, :update]
  resources :likes, only: [:create, :destroy] 

  get 'people', to: 'users#people', as: 'people'
  
end
