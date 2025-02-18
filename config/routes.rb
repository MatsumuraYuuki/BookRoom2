Rails.application.routes.draw do
  devise_for :users
  root 'posts#index'
  
  # 一般ユーザー用のルーティング
  resources :users, only: [:index, :show] do
    member do
      get :following, :followers
    end
  end
  resources :posts, only: [:new, :create, :show, :index, :destroy, :edit]
  resources :relationships, only: [:create, :destroy]

  # 管理者用のルーティング
  namespace :admin do
    resources :users, only: [:destroy]
  end
end
