Rails.application.routes.draw do
  root to: 'users#index'

  get "signup", to: "users#new", as: "signup"
  post "login", to: "sessions#create", as: "login"
  get "logout", to: "sessions#destroy", as: "logout"
end
