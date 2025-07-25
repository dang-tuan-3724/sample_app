Rails.application.routes.draw do
  get "password_resets/new"
  get "password_resets/edit"
  get "account_activations/edit"
  get "sessions/new"

  get "signup" => "users#new"
  get "help" => "static_pages#help"
  get "about" => "static_pages#about"
  get "contact" => "static_pages#contact"

  get    "login",   to: "sessions#new"
  post   "login",   to: "sessions#create"
  delete "logout",  to: "sessions#destroy"

  get "up" => "rails/health#show", as: :rails_health_check

  root "static_pages#home"

  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :account_activations, only: [ :edit ]
  resources :password_resets,     only: [ :new, :create, :edit, :update ]
  resources :microposts,          only: [ :create, :destroy ]
  resources :relationships,       only: [ :create, :destroy ]
end
