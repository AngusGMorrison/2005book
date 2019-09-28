Rails.application.routes.draw do
  root "static#index"

  # Sessions
  post "/session", to: "session#create"

  # Users
  get "/register", to: "users#new", as: "register"
  post "/register", to: "users#create", as: "new_user"
  get "/profile", to: "users#show", as: "profile"

  resources :groups
  resources :mods
  resources :messages
  resources :photos

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
