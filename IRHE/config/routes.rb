IRHE::Application.routes.draw do

root to: 'static_pages#home'

get '/signin' => redirect("/auth/twitter")
get '/signout' => "sessions#destroy"
get "auth/twitter/callback" => "sessions#create"
end
