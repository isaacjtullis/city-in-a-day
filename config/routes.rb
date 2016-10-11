Rails.application.routes.draw do
  devise_for :users
  root 'trails#index'

  resources :trails
end
