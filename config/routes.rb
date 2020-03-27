Rails.application.routes.draw do
  root to: 'users#index'

  post "signup", to: "users#create", as: "signup"
  post "login", to: "sessions#create", as: "login"
  get "logout", to: "sessions#destroy", as: "logout"

  get "all_users", to: "users#all_users", as: "all_users"
end
