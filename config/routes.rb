Rails.application.routes.draw do
  get '/', to: 'tasks_list#index'
  # post "/" => 'tasks_list#index'
  # get '/new', to: 'tasks_list#new'
  # post '/new' => 'tasks_list#new'
  # get '/tasks_list/:id' => 'tasks_list#update'
  # post '/tasks_list/:id' => 'tasks_list#update'
  resources :tasks_list

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
