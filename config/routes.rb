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

  resources :books, only: [] do  # 個別のアクションは不要
    collection do
      get 'search'
    end
  end

  resources :bookshelves, only: [:index, :create, :update, :destroy]

  # 管理者用のルーティング
  namespace :admin do
    resources :users, only: [:destroy]
  end
end
