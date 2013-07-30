IRHE::Application.routes.draw do

root to: 'static_pages#home'

resources :users , :texts

namespace :users do 
  resources :texts, :words
end

get '/signin' => redirect("/auth/twitter")
get '/signout', to: "sessions#destroy", via: :delete
get "auth/twitter/callback", to: "sessions#create"
get "/panel", to: "users#main", :as => 'panel'
end
