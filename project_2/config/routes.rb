Rails.application.routes.draw do

  resources :users
  get "/sign_in", to: "sessions#new"
  get "/sign_out", to: "sessions#destroy", as: 'sign_out'
  resources :events
  root 'welcome#index'
  post "/sessions", to: "sessions#create"


end
