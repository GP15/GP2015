Rails.application.routes.draw do

  root 'admin_dashboard#index'

  resources :cities, path: 'city'

  resources :partners

  get 'admin', to: 'admin_dashboard#index'

end
