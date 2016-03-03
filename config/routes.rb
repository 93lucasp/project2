Rails.application.routes.draw do

  resources :users, except: :index do
    #NOTE: this should represent CRUDing attendances
    resources :events
  end

  #NOTE: I would have another set of routes just `resources :events` (not nested) to allow the user to CRUD their own events.

  get "/events/:id", to: "events#show"

  get "/sign_in", to: "sessions#new"
  get "/sign_out", to: "sessions#destroy", as: 'sign_out'

  root 'welcome#index'
  post "/sessions", to: "sessions#create"
  #FIXME: the below route is not restful. you may want `post /users/:user_id/events` instead. Also it looks like it's already defined above for you with `resources`.
  post "/users/:user_id/events/:event_id", to: "attendances#joinEvent"
  get "/users/:user_id/events", to: "attendances#index", as: "user_events_test"


end
