Rails.application.routes.draw do

  namespace :api, { format: 'json' }   do
    resources :tasks, only: [:update]
    get 'tasks/calendar' => 'tasks#calendar'
    get 'tasks/mail' => 'tasks#mail'
  end

  root 'tasks#index'
  resources :tasks, except: [:index]
  get '/my_tasks' => 'tasks#index'
  resources :users, except: [:index, :destroy]
  get '/calendar' => 'tasks#calendar'
  resources :groups, except: [:index, :destroy] do
    resources :tasks, except: [:index] do
      collection do
        get '/' => 'tasks#index_group'
      end
    end
    resources :group_users, only: [:destroy, :show]
  end

  namespace :admin do
    root 'tasks#index'
    resources :tasks, except: [:index]
    get '/calendar' => 'tasks#calendar'
    get '/my_tasks' => 'tasks#index'
    resources :users, :labels
    resources :groups do
      resources :tasks, except: [:index] do
        collection do
          get '/' => 'tasks#index_group'
        end
      end
      resources :group_users, only: [:destroy, :show]
    end
  end

  get 'login', to: 'sessions#new'
  post 'login' => 'sessions#create'
  get 'sessions/destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
