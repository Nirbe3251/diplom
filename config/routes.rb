Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'projects#index'
  resources :projects
  resources :checklists
  resources :test_cases
  resources :roles
  resources :bugreports

  get 'user/:id', to: 'users#index', as: 'user'
end
