Rails.application.routes.draw do
  # EXAMPLE HTML ROUTE
  # get "/photos" => "photos#index"

  # EXAMPLE JSON ROUTE WITH API NAMESPACE
  namespace :api do
    get '/courses' => 'courses#index'
    get '/courses/:name' => 'courses#show'

    get '/users' => 'users#index'
    post '/users' => 'users#create'

    get '/planners' => 'planners#index'
    get '/planner/:id' => 'planners#show'
    post '/planner' => 'planners#create'

    post '/sessions' => 'sessions#create'
  end

  get '/courses' => 'courses#index'
end
