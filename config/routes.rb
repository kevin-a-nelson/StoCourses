Rails.application.routes.draw do
  # EXAMPLE HTML ROUTE
  # get "/photos" => "photos#index"

  # EXAMPLE JSON ROUTE WITH API NAMESPACE
  namespace :api do

    # Users CRUD
    get '/users' => 'users#index'
    get '/users/:id' => 'users#show'
    patch '/users/:id' => 'users#update'
    post '/users' => 'users#create'
    delete '/users/:id' => 'users#destroy'

    # Planners CRUD
    get '/planners' => 'planners#index'
    get '/planner/:id' => 'planners#show'
    patch '/planner/:id' => 'planners#update'
    post '/planner' => 'planners#create'
    delete 'planner/:id' => 'planner#delete'

    # Terms CRUD
    get '/terms' => 'terms#index'
    get '/terms/:id' => 'terms#show'
    patch '/terms/:id' => 'terms#update'
    post '/terms' => 'terms#create'
    delete '/terms/:id' => 'terms#destroy'

    # Courses CRUD
    get '/courses' => 'courses#index'
    get '/courses/:name' => 'courses#show'

    # Sessions Create
    post '/sessions' => 'sessions#create'
  end

  get '/courses' => 'courses#index'
end
