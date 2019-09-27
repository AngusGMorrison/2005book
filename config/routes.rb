Rails.application.routes.draw do
  root "static#index"

  # Sessions
  post "/session", to: "session#create"

  # Users
  get "/register", to: "users#new", as: "register"
  post "/users", to: "users#create", as: "new_user"

  resources :groups
  resources :mods
  resources :messages
  resources :photos

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
