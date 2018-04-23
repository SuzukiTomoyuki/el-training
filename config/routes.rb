Rails.application.routes.draw do
  get '/', to: 'tasks_list#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
