Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "posts#index"
  resources :users, except: [:new, :create]

  resources :users do 
    resources :posts, only: [:index]
    resources :friendships, only: [:index, :create, :destroy]
    resources :requests, only: [:index, :create, :destroy]
    resources :invitations, only: [:index, :create, :destroy]
  end

  resources :comments, only: [:new, :create, :destroy]

  resources :posts, except: [:edit, :update]
  resources :likes, only: [:create, :destroy] 

  get 'people', to: 'users#people', as: 'people'
  
end
