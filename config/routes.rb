Rails.application.routes.draw do
  resources :paragraphs

  resources :texts

  resources :users

  root "users#index"

  get '/auth/:provider/callback' , to: 'sessions#create'
end
