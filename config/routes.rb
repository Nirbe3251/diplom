Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'projects#index'
  resources :projects do
    member do
      post :add_users
    end
  end
  resources :checklists
  resources :test_cases, except: %w[index show new edit destroy update] do
    collection do
      post :create_test_suites
    end
  end
  resources :roles
  resources :bugreports
  resources :test_plans
  resources :releases do
    member do
      get :get_chart_data
    end
  end

  get 'user/:id', to: 'users#index', as: 'user'

  get '/test_cases/:id', to: 'test_cases#test_suites', as: 'test_suite'
  get '/test_cases/:id/new', to: 'test_cases#new', as: 'new_test_case'
  get '/test_cases', to: 'test_cases#index', as: 'test_suites'
  get '/test_cases/:id/:test_case_id', to: 'test_cases#show', as: 'show_test_case'
  get '/test_cases/:id/:test_case_id/edit', to: 'test_cases#edit', as: 'edit_test_case'
  put '/test_cases/:id/:test_case_id', to: 'test_cases#update', as: 'update_test_case'
  delete '/test_cases/:id/:test_case_id', to: 'test_cases#destroy', as: 'delete_test_case'
  delete '/test_cases/:id', to: 'test_cases#destroy_test_suite', as: 'delete_test_suite'
  put '/test_cases/:id', to: 'test_cases#edit_test_suite', as: 'edit_test_suite'

  get '/download_file', to: 'application#download_file', as: 'download_file'
end
