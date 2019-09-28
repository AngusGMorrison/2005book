Rails.application.routes.draw do
  root "static#index"

  # Sessions
  get "/login", to: "session#new", as: "login"
  get "/logout", to: "session#destroy", as: "logout"
  post "/login", to: "session#create"

  # Users
  get "/register", to: "users#new", as: "register"
  post "/register", to: "users#create", as: "create_user"
  get "/profile", to: "users#show", as: "profile"

  resources :groups
  resources :mods
  resources :messages
  resources :photos

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
