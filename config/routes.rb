Rails.application.routes.draw do
  resources :users
  # resources :search_logs
  # devise_for :users
  resources :search_logs, only: [:index]
  
  resources :articles do
    collection do
      get 'search'
    end
  end
  get 'destroy_user_cookie', to: 'application#destroy_user_cookie'
  get '/update_search_counts', to: 'articles#update_search_counts'
  # post '/track_search', to: 'tracking#track_search'
  root 'articles#index'
  mount ActionCable.server => "/cable"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  #root "home#index"
end