Rails.application.routes.draw do
  root 'top#index'

  get 'login' => 'user_sessions#new', as: :login
  post 'logout' => 'user_sessions#destroy', as: :logout

  namespace :api, format: 'json' do
    resources :topics, only: %i(create) do
      scope module: :topics do
        resources :comments, only: %i(create)
      end
    end
    resources :categories, only: %i(index)
    resources :emoji, only: :index
    post 'reactions/:type/' => 'reactions#create'
    post 'reactions/:type/:reactionable_id' => 'reactions#destroy'
  end

  resources :topics do
    get :count_map
    collection do
      get :complete
    end
    scope module: :topics do
      get 'comments/:no/anchor' => 'comments#anchor', as: 'anchor'
    end
  end
  resource :home, only: %i(show edit update) do
    get :email
    get :password
    patch :update_email
    patch :update_password
  end
  resources :categories, only: :show, path: 'category'
  resources :user_sessions
  resources :members, only: %i(index show new create destroy)
  resources :tags, only: :show

  resources :admin, only: :index
  namespace :admin do
    resources :tags
    namespace :tags do
      resource :associate_with_model, only: %i(new create)
    end
  end
end
