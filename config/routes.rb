Rails.application.routes.draw do
  root to: 'users#index'

  post "signup", to: "users#create", as: "signup"
  post "login", to: "sessions#create", as: "login"
  get "logout", to: "sessions#destroy", as: "logout"

  get "get_friends", to: "users#all_friends", as: "get_friends"
  post "add_friend", to: "users#add_friend", as: "add_friend"
  get "my_direct_rooms", to: "rooms#my_direct_rooms", as: "my_direct_rooms"
end
