Rails.application.routes.draw do

  root 'admin#index'

  resources :cities, path: 'city'

  resources :partners do
    resources :klasses
  end

  resources :activities

  get 'admin',              to: 'admin#index'
  get 'admin/partners/:id', to: 'admin#partner', as: 'admin_partner'

end
