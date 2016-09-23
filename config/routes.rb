Rails.application.routes.draw do
  root 'top#index'
  resources :user_sessions
  resources :users

  get 'login' => 'user_sessions#new', as: :login
  post 'logout' => 'user_sessions#destroy', as: :logout
end
