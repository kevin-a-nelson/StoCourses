Rails.application.routes.draw do
  # EXAMPLE HTML ROUTE
  # get "/photos" => "photos#index"

  # EXAMPLE JSON ROUTE WITH API NAMESPACE
  namespace :api do
    get '/courses' => 'courses#index'

    post '/users' => 'users#create'

    post '/sessions' => 'sessions#create'
  end

  get '/courses' => 'courses#index'
end
