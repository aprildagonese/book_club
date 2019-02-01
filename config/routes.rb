Rails.application.routes.draw do
  root 'welcome#index'

  resources :authors, only: [:show]
  resources :books, only: [:new, :create]
  resources :reviews, only: [:show, :update, :edit]
  resources :users

  resources :books, only: [:index, :show, :update, :edit] do
    resources :reviews, only: [:new, :create]
  end
end
