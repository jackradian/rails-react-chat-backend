Rails.application.routes.draw do
  root to: 'users#index'

  post "signup", to: "users#create", as: "signup"
  post "login", to: "sessions#create", as: "login"
  get "logout", to: "sessions#destroy", as: "logout"

  get "get_friends", to: "users#all_friends", as: "get_friends"
end
