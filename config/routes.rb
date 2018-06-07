Rails.application.routes.draw do


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

  get 'users/new'

  root 'tasks#index'
  resources :tasks, :users

  # resources :groups

  resources :groups do
    resources :tasks, except: [:index] do
      collection do
        get '/' => 'tasks#index_group'
      end
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
