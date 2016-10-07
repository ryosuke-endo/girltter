Rails.application.routes.draw do
  root 'top#index'

  get 'login' => 'user_sessions#new', as: :login
  post 'logout' => 'user_sessions#destroy', as: :logout

  resources :loves do
    scope module: :loves do
      resources :supplementals, only: %i(new create destroy)
    end
  end
  resources :categories, only: :show
  resources :user_sessions
  resources :members
  resources :tags, only: :show

  resources :admin, only: :index
  namespace :admin do
    resources :tags
    namespace :tags do
      resource :associate_with_model, only: %i(new create)
    end
  end
end
