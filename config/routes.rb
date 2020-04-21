Rails.application.routes.draw do
  root to: 'toppages#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :users

  get 'signup', to: 'users#new'

  resources :cars

  resources :circuits

  resources :ownerships, only: [:create, :destroy]

  resources :joins, only: [:create, :destroy]

  resources :events, only: [:show, :edit, :create, :destroy]

  resources :datalists, only: [:show, :create, :destroy]
  get 'userdata', to: 'datalists#userdata'

  resources :heats

  resources :tires

end
