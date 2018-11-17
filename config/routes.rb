Rails.application.routes.draw do
  resources :users
  resources :credit_cards
  resources :lake_dests
  resources :trips
  resources :bookings
  get 'lakes/index'
  root 'lakes#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
