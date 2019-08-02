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
    get '/planners/:id/terms' => 'planners#terms'
    get '/planners/:id/terms/:id/courses' => 'planners#courses'
    post '/planners' => 'planners#create'
    patch '/planners/:id' => 'planners#update'
    delete 'planners/:id' => 'planners#destroy'

    # Terms CRUD
    get '/terms' => 'terms#index'
    get '/terms/:id' => 'terms#show'
    get '/terms/:planner_id/:id/courses' => 'terms#courses'
    post '/terms/:planner_id' => 'terms#create'
    patch '/terms/:id' => 'terms#update'
    delete '/terms/:id' => 'terms#destroy'

    # Courses CRUD
    get '/courses' => 'courses#index'
    get '/courses/:id' => 'courses#show'
    post '/courses' => 'courses#create'
    patch '/courses/:id' => 'courses#update'
    delete '/courses/:id' => 'courses#destroy'

    # CourseTerms CRUD
    get '/course_terms' => 'course_terms#index'
    get '/course_terms/:id' => 'course_terms#show'
    post '/course_terms' => 'course_terms#create'
    patch '/course_terms/:id' => 'course_terms#update'
    delete '/course_terms/:id' => 'course_terms#destroy'

    # Sessions Create
    post '/sessions' => 'sessions#create'
  end

  get '/courses' => 'courses#index'
end
