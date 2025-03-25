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
  resources :test_cases
  resources :roles
  resources :bugreports

  get 'user/:id', to: 'users#index', as: 'user'
end
