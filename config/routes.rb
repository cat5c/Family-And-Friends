Rails.application.routes.draw do

  root 'pictures#index'

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

  # get '/users', to: redirect("/users/#{current_user.id}")
  get '/users/' => 'users#index'
  get '/users/:id' => 'users#show', as: 'user'
  get '/users/:id/comments' => 'users#comments'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  get '/signup' => 'users#new'
  post '/users' => 'users#create'

  get '/cities' => 'cities#index'
  get '/cities/:id' => 'cities#show'
  get '/cities/:id/all' => 'cities#all'

end