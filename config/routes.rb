Rails.application.routes.draw do
  resources :users
  root 'top#index'
end
