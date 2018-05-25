Rails.application.routes.draw do

  namespace :admin do
    root 'tasks#index'
    resources :tasks
  end

  get 'login', to: 'sessions#new'

  post 'login' => 'sessions#create'

  get 'sessions/destroy'

  get 'users/new'

  get '/', to: 'tasks#index'
  # post "/" => 'tasks#details_task'
  # get '/new', to: 'tasks#new'
  # post '/new' => 'tasks#new'
  # get '/tasks/:id' => 'tasks#update'
  # post '/tasks/:id' => 'tasks#update'
  resources :tasks, :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
