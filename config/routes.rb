Rails.application.routes.draw do
  resources :books do
    resources :comments, only: [:new, :create]
  end
  root 'books#index'

  resources :users

  get '/login' => 'session#new'
  post '/login' => 'session#create'
  get '/logout' => 'session#destroy'
end
