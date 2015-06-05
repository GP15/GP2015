Rails.application.routes.draw do

  root 'admin_dashboard#index'

  resources :cities, path: 'city'

  resources :partners do
    resources :klasses
  end

  resources :activities

  get 'admin',              to: 'admin_dashboard#index'
  get 'admin/partners/:id', to: 'admin_dashboard#partner', as: 'admin_partner'

end
