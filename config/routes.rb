Rails.application.routes.draw do
  # EXAMPLE HTML ROUTE
  # get "/photos" => "photos#index"

  # EXAMPLE JSON ROUTE WITH API NAMESPACE
  namespace :api do

    # Profs CRUD
    
    get '/profs' => 'profs#index'

    # Users CRUD
    # resources :users
    get '/users' => 'users#index'
    get '/users/:id' => 'users#show'
    patch '/users/:id' => 'users#update'
    post '/users' => 'users#create'
    delete '/users/:id' => 'users#destroy'

    get '/tests' => 'test#index'

    # Terms CRUD
    # resources :terms
    get '/terms' => 'terms#index'
    get '/terms/:id' => 'terms#show'
    get '/terms/:id/courses' => 'terms#courses'
    post '/terms' => 'terms#create'
    patch '/terms/:id' => 'terms#update'
    delete '/terms/:id' => 'terms#destroy'

    # Courses CRUD
    get '/courses' => 'courses#index'
    get '/courses/:id' => 'courses#show'
    get '/courses/:id/labs' => 'courses#labs'
    post '/courses' => 'courses#create'
    patch '/courses/:id' => 'courses#update'
    delete '/courses/:id' => 'courses#destroy'

    # CourseTerms CRUD
    get '/course_terms' => 'course_terms#index'
    get '/course_terms/:id' => 'course_terms#show'
    post '/course_terms' => 'course_terms#create'
    patch '/course_terms/:id' => 'course_terms#update'
    delete '/course_terms/:term_id/:course_id' => 'course_terms#destroy'

    # Sessions Create
    post '/sessions' => 'sessions#create'
  end

  get '/courses' => 'courses#index'
end
