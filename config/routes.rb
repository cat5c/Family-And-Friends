Rails.application.routes.draw do

  root 'pictures#index'

  #additional pictures routes
  get 'pictures/all' => 'pictures#all'
  get 'pictures/alltime' => 'pictures#alltime'
  get 'pictures/allpics' => 'pictures#allpics'

  resources :pictures do
  	resources :comments
    member do
      put "like", to: "pictures#like"
      put "unlike", to: "pictures#unlike"
    end
  end

  #users routes
  get '/users/' => 'users#index'
  get '/users/:id' => 'users#show', as: 'user'
  get '/users/:id/comments' => 'users#comments'

  #login routes
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  #signup routes
  get '/signup' => 'users#new'
  post '/users' => 'users#create'

  #cities routes
  get '/cities' => 'cities#index'
  get '/cities/:id' => 'cities#show'
  get '/cities/:id/all' => 'cities#all'

end