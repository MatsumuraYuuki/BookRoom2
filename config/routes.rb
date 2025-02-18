Rails.application.routes.draw do
  devise_for :users
  root 'posts#index'
  resources :users, only: [:index, :show, :destroy] do
    member do
      get :following, :followers
    end
  end
  resources :posts, only: [:new, :create, :show, :index, :destroy, :edit]
  resources :relationships, only: [:create, :destroy]

end
