Rails.application.routes.draw do
  # EXAMPLE HTML ROUTE
  # get "/photos" => "photos#index"

  # EXAMPLE JSON ROUTE WITH API NAMESPACE
  namespace :api do
    get '/courses' => 'courses#index'

    get '/users' => 'users#index'
    post '/users' => 'users#create'

    get '/planner/:id' => 'planners#show'
    post '/planner' => 'planners#create'

    post '/sessions' => 'sessions#create'
  end

  get '/courses' => 'courses#index'
end
