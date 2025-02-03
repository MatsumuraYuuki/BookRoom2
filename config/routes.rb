Rails.application.routes.draw do
  devise_for :users
  root 'posts#index'
  resources :users, only: [:index, :show]
  resources :posts, only: [:new, :create, :show, :index, :destroy]
end
