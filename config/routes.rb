Rails.application.routes.draw do
  root to: "home#index"
  get "/auth/twitter", as: :login
  get "/auth/twitter/callback", to: "sessions#create"
  get "/logout", to: "sessions#destroy", as: :logout
  resources :users, only: [:show]
end
