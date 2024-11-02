# frozen_string_literal: true

Rails.application.routes.draw do
  resources :languages
  get  "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create"
  get  "sign_up", to: "registrations#new"
  post "sign_up", to: "registrations#create"
  resources :sessions, only: %i[index show destroy]
  resource  :password, only: %i[edit update]
  namespace :identity do
    resource :email,              only: %i[edit update]
    resource :email_verification, only: %i[show create]
    resource :password_reset,     only: %i[new edit create update]
  end
  resources :workspaces, shallow: true do
    resources :members
    resources :boards do
      resources :lists, except: [:index] do
        resources :cards, except: [:index]
      end
    end
  end
  get "settings", to: "settings#index"
  get "help", to: "help#index"

  get "login", to: "sessions#new"

  root "home#index"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Route to change locale
  patch "change_locale", to: "settings#change_locale"

  # Defines the root path route ("/")
  # root "posts#index"
end
