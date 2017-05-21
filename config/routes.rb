Rails.application.routes.draw do
  get "auth/:provider/callback", to: "sessions#create"
  get "auth/failure", to: "sessions#failure"
  delete "signout", to: "sessions#destroy", as: "signout"

  resources :lists do
    member do
      patch :add_user
    end

    resources :tasks, except: [:index, :show] do
      member do
        patch :complete
      end
    end
  end

  root to: "home#show"
end
