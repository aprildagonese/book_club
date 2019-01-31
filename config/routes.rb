Rails.application.routes.draw do
  root 'welcome#index'

  resources :authors, only: [:show]
    resources :books, only: [:new, :create]

  resources :books, only: [:index, :show, :update, :edit] do
    resources :reviews, only: [:new, :create]
  end

  resources :reviews, only: [:show, :update, :edit]
  resources :users
end
