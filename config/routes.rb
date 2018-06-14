Rails.application.routes.draw do

  root 'tasks#index'

  namespace :api do
    resources :tasks, only: [:update]
  end

  resources :tasks, :users
  resources :groups do
    resources :tasks, except: [:index] do
      collection do
        get '/' => 'tasks#index_group'
      end
    end
    resources :group_users, only: [:destroy, :update]
    resources :user do
    end
  end

  namespace :admin do
    root 'tasks#index'
    resources :tasks, :users, :labels
    resources :groups do
      resources :tasks, except: [:index] do
        collection do
          get '/' => 'tasks#index_group'
        end
      end
    end
  end

  get 'login', to: 'sessions#new'
  post 'login' => 'sessions#create'
  get 'sessions/destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
