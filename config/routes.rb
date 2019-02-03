Rails.application.routes.draw do
  root 'welcome#index'

  resources :authors, only: [:show, :destroy]
  resources :books, only: [:new, :create, :index]
  resources :reviews, only: [:show, :update, :edit, :destroy]
  resources :users

  resources :books, only: [:show, :update, :edit] do
    resources :reviews, only: [:new, :create]
  end
end
