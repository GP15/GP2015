Rails.application.routes.draw do

  root 'static_pages#index'

  resources :cities, path: 'city'

  resources :partners do
    resources :klasses, :schedules
  end

  resources :activities

  get 'admin',              to: 'admin#index'
  get 'admin/partners/:id', to: 'admin#partner', as: 'admin_partner'

end
