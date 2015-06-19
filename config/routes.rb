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

  # Devise settings
    devise_for :admins, path_names: { sign_in: 'login', sign_out: 'logout'}

    as :admin do
      get   'admin/edit', to: 'devise/registrations#edit',   as: 'edit_admin_registration'
      patch 'admin/:id',  to: 'devise/registrations#update', as: 'admin_registration'
    end
  # end Devise settings
end
