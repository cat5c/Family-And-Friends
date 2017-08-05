Rails.application.routes.draw do
  resources :pictures
  get '/users' => 'users#index'
  get '/users/:id' => 'users#show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
