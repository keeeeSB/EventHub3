Rails.application.routes.draw do
  root "users#new"
  get "/signup",    to: "users#new"
  post "/signup",   to: "users#create"
  get "/login",     to: "sessions#new"
  post "/login",    to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :users, only: [:show] do
    resources :events
  end
  resources :account_activations, only: [:edit]
end
