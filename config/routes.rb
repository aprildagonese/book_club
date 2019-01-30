Rails.application.routes.draw do
  get '/books', to: 'books#index'

  get '/authors/:id', to: 'authors#show' 
end
