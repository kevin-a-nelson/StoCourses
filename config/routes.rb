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
    get '/planners/:id' => 'planners#show'
    patch '/planners/:id' => 'planners#update'
    post '/planners' => 'planners#create'
    delete 'planners/:id' => 'planners#destroy'

    # Terms CRUD
    get '/terms' => 'terms#index'
    get '/terms/:id' => 'terms#show'
    patch '/terms/:id' => 'terms#update'
    post '/terms/:planner_id' => 'terms#create'
    delete '/terms/:id' => 'terms#destroy'

    # Courses CRUD
    # Courses will be Updated and created though seeds folder
    get '/courses' => 'courses#index'
    get '/courses/:id' => 'courses#show'

    # Sessions Create
    post '/sessions' => 'sessions#create'
  end

  get '/courses' => 'courses#index'
end
