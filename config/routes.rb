IRHE::Application.routes.draw do

mount RedactorRails::Engine => '/redactor_rails'
root to: 'static_pages#home'

resources :users , :texts, :words

  namespace :users do
    resources :texts, :words
  end

  get '/signin' => redirect("/auth/twitter")
  get '/signout', to: "sessions#destroy", via: :delete
  get "auth/twitter/callback", to: "sessions#create"
  get "/panel", to: "users#main", :as => 'panel'
  post "/search", to: "texts#wordsearch"
  post "/dic", to: "texts#lookup"
end
