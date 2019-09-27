Rails.application.routes.draw do
  root "static#index"

  # Sessions
  post "/sessions", to: "sessions#create"

  # Users
  get "/register", to: "sessions#new", as: "register"

  resources :groups
  resources :mods
  resources :messages
  resources :photos
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
