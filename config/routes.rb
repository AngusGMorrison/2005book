Rails.application.routes.draw do
  root "static#index"

  # Sessions
  get "/login", to: "session#new", as: "login"
  get "/logout", to: "session#destroy", as: "logout"
  post "/login", to: "session#create"


  # Users
  get "/users/index", to: "users#index", as: "users"
  get "/register", to: "users#new", as: "register"
  post "/register", to: "users#create", as: "create_user"
  get "/users/:id/friends", to: "users#friends", as: "friends"


  # Profile
  get "/profiles/:slug", to: "profiles#show", as: "profile"

  
  # Friendships
  get "/friendships", to: "friendships#index", as: "friendships"
  get "/friendships/new", to: "friendships#new", as: "new_friendship"
  post "/friendships", to: "friendships#create"
  patch "/friendships/:id", to: "friendships#update", as: "update_friendship"
  delete "/friendships/:id", to: "friendships#destroy", as: "destroy_friendship"
  get "friendships/requests", to: "friendships#requests", as: "requests"


  # Chains
  get "/chains", to: "chains#index", as: "chains"
  get "/chains/new", to: "chains#new", as: "new_chain"
  get "/chains/:id", to: "chains#show", as: "chain"
  post "/chains", to: "chains#create", as: "create_chain"


  # Messages
  get "/messages", to: "messages#user_messages", as: "user_messages"
  get "/messages/new", to: "messages#new", as: "new_message"



  

  resources :groups
  resources :mods
  resources :messages
  resources :photos

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
