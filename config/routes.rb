Rails.application.routes.draw do
  root   'home#index'
  get    '/sign-in'                 =>  'sessions#new', as: :signin
  delete '/logout'                  =>  'sessions#destroy', as: :logout
  get    '/auth/:provider/callback' =>  'sessions#create'
  get    '/suggestions'             =>  'suggestions#index'
  post   '/suggestions'             =>  'suggestions#create'
  get    '/favorites'               =>  'suggestions#favorites', as: :favorites
  post   '/favorite'                =>  'suggestions#favorite'
  post   '/unfavorite'              =>  'suggestions#unfavorite'
end
