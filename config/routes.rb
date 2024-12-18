Rails.application.routes.draw do
  root "events#upcoming"
  get "/signup",    to: "users#new"
  post "/signup",   to: "users#create"
  get "/login",     to: "sessions#new"
  post "/login",    to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :users, only: [:show] do
    resources :events do
      collection do
        get :upcoming
        get :past
      end
      resource :join,     only: [:create, :destroy]
      resource :favorite, only: [:create, :destroy]
      resource :review,   only: [:create, :edit, :update, :destroy]
    end
    resources :joins,     only: [:index]
    resources :favorites, only: [:index]
  end
  resources :account_activations, only: [:edit]
end
