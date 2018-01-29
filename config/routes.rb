Rails.application.routes.draw do
  devise_for :users
  root 'trails#index'

  resources :trails do
    resources :comments, only: [:create, :edit, :destroy]
    resources :locations
  end

  resources :searches

  namespace :api do
    namespace :v1 do
      resources :locations
      resources :trails
    end
  end

  resources :profiles
  resources :favorites, only: [:create, :destroy, :update, :destroy]
  resources :relationships, only: [:create, :destroy]
end
