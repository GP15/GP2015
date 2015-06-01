Rails.application.routes.draw do

  root 'cities#index'

  resources :cities, path: 'city'

  resources :partners

end
