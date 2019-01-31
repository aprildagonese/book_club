Rails.application.routes.draw do
  root 'welcome#index'

  resources :books, only: [:index, :show]
  resources :authors, only: [:show]
  resources :reviews, only: [:show]
  resources :users, only: [:show]
end
