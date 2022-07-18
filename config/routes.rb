Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resource :users, only: [:create]
  post "/login", to: "users#login"
  get "/auto_login", to: "users#auto_login"
  post "/create", to: "users#create"
  put "/users/:id", to: "users#update"
  delete "/users/:id", to: "users#destroy"

end
