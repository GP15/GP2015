Rails.application.routes.draw do

  root 'static_pages#index'

  resources :schedules, only: [:index, :show]

  resources :partners do
    resources :klasses
    resources :schedules, except: [:index, :show]
  end

  get 'admin',              to: 'admin#index'
  get 'admin/partners/:id', to: 'admin#partner', as: 'admin_partner'

  resources :cities, path: 'city', except: [:index, :show]
  resources :activities, except: [:index, :show]
end
