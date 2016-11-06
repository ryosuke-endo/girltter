Rails.application.routes.draw do
  root 'top#index'

  get 'login' => 'user_sessions#new', as: :login
  post 'logout' => 'user_sessions#destroy', as: :logout

  resources :loves do
    scope module: :loves do
      resources :supplementals, only: %i(new create destroy)
    end
  end
  resource :home, only: %i(show edit update) do
    get :email
    get :password
    patch :update_email
    patch :update_password
  end
  resources :categories, only: :show
  resources :user_sessions
  resources :members, only: %i(index show new create destroy)
  resources :tags, only: :show
  resources :comments, only: %i(create destroy)

  resources :admin, only: :index
  namespace :admin do
    resources :tags
    namespace :tags do
      resource :associate_with_model, only: %i(new create)
    end
  end
end
