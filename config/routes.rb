Rails.application.routes.draw do
  get 'password_resets/new'

  get 'password_resets/edit'

  get "/contact", to: "static_pages#contact"

  get "/about", to: "static_pages#about"

  get "/help", to: "static_pages#help"

  get "/signup", to: "users#new"

  post "/signup", to: "users#create"

  get "/login", to: "sessions#new"

  post "/login", to: "sessions#create"

  delete "/logout", to: "sessions#destroy"

  root "static_pages#home"

  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
end
