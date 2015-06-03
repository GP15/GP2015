Rails.application.routes.draw do

  root 'admin_dashboard#index'

  resources :cities, path: 'city'

  resources :partners

  resources :activities

  get 'admin', to: 'admin_dashboard#index'

end
