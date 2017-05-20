Rails.application.routes.draw do
  get "auth/:provider/callback", to: "sessions#create"
  get "auth/failure", to: "sessions#failure"
  delete "signout", to: "sessions#destroy", as: "signout"

  resources :lists

  root to: "home#show"
end
