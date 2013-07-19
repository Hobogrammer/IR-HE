IRHE::Application.routes.draw do

root to: 'static_pages#home'

resources :users , :texts

namespace :users do 
  resources :texts, :words
end

get '/signin' => redirect("/auth/twitter")
get '/signout' => "sessions#destroy"
get "auth/twitter/callback" => "sessions#create"
end
