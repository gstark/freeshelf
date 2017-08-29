jails.application.routes.draw do
  resources :books

  get '/signup' => 'users#new'
  post '/users' => 'users#create'
end
