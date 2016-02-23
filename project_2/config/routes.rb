Rails.application.routes.draw do

  
  resources :users, except: :index do
  resources :events
  end

  get "/sign_in", to: "sessions#new"
  get "/sign_out", to: "sessions#destroy", as: 'sign_out'

  root 'welcome#index'
  post "/sessions", to: "sessions#create"


end
