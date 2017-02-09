Rails.application.routes.draw do
  root "static_pages#home", page: "home"
  get "/static_pages/page", to: "static_pages#home"
  get "/signup", to: "users#new"
  post "/signup",  to: "users#create"
  resources :users, only: :show
end
