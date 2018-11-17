Rails.application.routes.draw do
  get 'sessions/new'
  resources :users
  resources :trips
  resources :credit_cards
  resources :lake_dests
  resources :bookings
  get 'lakes/index'
  root 'lakes#index'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
