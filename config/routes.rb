Rails.application.routes.draw do
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
  resources :users #cai nay la co day du cac rest actions: index, show, new, create, edit, update, destroy
  resources :account_activations, only: [:edit]
end
