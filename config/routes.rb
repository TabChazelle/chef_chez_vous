Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  patch '/update_profile', to: 'users#update_profile', as: 'update_profile'


  resources :bookings, only: %i[new create show edit update index destroy]
  resources :chefs, only: %i[new create show edit update index]

  # Possibly needing to add resources for users if we are going to have a profile page.
  # We do not need if it is only used for devise authentication.
  resources :users, only: %i[show edit update]
  resources :users do
    get 'profile', on: :member
  end
  # Defines the root path route ("/")
  # root "posts#index"
  resources :users do
    patch 'toggle_chef', on: :member
  end

  get "/infinite_scroll", to: "pages#infinite_scroll"

end
