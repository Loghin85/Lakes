Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  get 'sessions/new'
  get 'bookings/:id/pay', to: 'bookings#pay', as: 'pay_booking'
  resources :users
  resources :trips
  resources :credit_cards
  resources :lake_dests
  resources :bookings
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  default_url_options :host => "example.com"
  get 'lakes/index'
  root 'lakes#index'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
