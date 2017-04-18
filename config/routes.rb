Rails.application.routes.draw do
  root 'top#index'

  namespace :api, format: 'json' do
    resources :topics, only: %i(create) do
      scope module: :topics do
        resources :comments, only: %i(create)
      end
    end
    resources :categories, only: %i(index)
    resources :icon, only: :index
    post 'reactions/:type/' => 'reactions#create'
    post 'reactions/:type/:reactionable_id' => 'reactions#destroy'
  end

  resources :topics do
    get :reaction_count_map
    collection do
      get :complete
    end
    scope module: :topics do
      get 'comments/:no/anchor' => 'comments#anchor', as: 'anchor'
    end
  end
  resources :categories, only: :show, path: 'category'
  get 'tags/:name' => 'tags#index', as: :tags
  get 'terms' => 'pages#terms'
end
