Rails.application.routes.draw do
  devise_for :users
  root 'trails#index'

  resources :trails do
    resources :comments, only: [:create, :edit, :destroy]
  end
  resources :profiles
  resources :favorites, only: [:create, :destroy, :update, :destroy]
end
