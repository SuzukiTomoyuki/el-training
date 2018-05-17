Rails.application.routes.draw do
  get 'users/new'

  get '/', to: 'tasks#index'
  # post "/" => 'tasks#index'
  # get '/new', to: 'tasks#new'
  # post '/new' => 'tasks#new'
  # get '/tasks/:id' => 'tasks#update'
  # post '/tasks/:id' => 'tasks#update'
  resources :tasks

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
