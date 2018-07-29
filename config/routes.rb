Rails.application.routes.draw do

  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :new, :create] do
    member do
      get :followings
      get :followers
      get :profile_new
    end
  end
  
  resources :relationships, only: [:create, :destroy]
  resources :messages, only: [:create]
  resources :profiles, only: [:create]
  resources :rooms, only: [:create, :show]
  resources :comments, only: [:create]
end
