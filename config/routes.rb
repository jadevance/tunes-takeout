Rails.application.routes.draw do
  root   'home#index'
  get    '/sign-in'                 =>  'sessions#new', as: :signin
  delete '/logout'                  =>  'sessions#destroy', as: :logout
  get    '/auth/:provider/callback' =>  'sessions#create'
  get    '/suggestions'             =>  'suggestions#index'
  post   '/suggestions'             =>  'suggestions#create'
  get    '/favorites'               =>  'suggestions#favorites', as: :favorites
  get    '/:uid/favorites'          =>  'users#favorites', as: :my_favorites
  post   '/:uid/favorites'          =>  'users#favorite', as: :favorite 
  delete '/:uid/favorites'          =>  'users#unfavorite'
end
