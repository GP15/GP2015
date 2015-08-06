Rails.application.routes.draw do

  root 'static_pages#index'
  get  'invite',  to: 'static_pages#invite'
  get  'pricing', to: 'static_pages#pricing'

  resources :schedules, only: [:index, :show] do
    resources :reservations, only: [:new, :create, :destroy]
  end

  devise_for :users, path_names: { sign_in: 'login', sign_out: 'logout' }

  resources :users, only: [:show] do
    resources :children, except: [:index, :show]
  end

  resources :partners do
    resources :klasses, :schedules, except: [:index, :show]
  end

  get 'admin',              to: 'admin#index'
  get 'admin/partners/:id', to: 'admin#partner', as: 'admin_partner'
  get 'admin/settings',     to: 'admin#settings'

  resources :cities, path: 'city', except: [:index, :show]
  resources :activities, except: [:index, :show]

  # Admin's Devise settings
  devise_for :admins, path: 'admin', path_names: { sign_in: 'login', sign_out: 'logout' }

  as :admin do
    get   'admin/profile', to: 'devise/registrations#edit',   as: :admin_root
    patch 'admin/:id',     to: 'devise/registrations#update', as: 'admin_registration'
  end

end
