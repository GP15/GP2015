Rails.application.routes.draw do
  get 'cards/new'

  root 'static_pages#index'

  get 'faq',     to: 'static_pages#faq'
  get 'terms',   to: 'static_pages#terms'
  get 'privacy', to: 'static_pages#privacy'

  post 'charged_successfully', to: 'subscriptions#charged_successfully'

  resources :schedules, only: [:index, :show] do
    patch 'archive',   on: :member
    patch 'unarchive', on: :member
    resources :reservations, only: [:new, :create, :destroy]
  end

  devise_for :users, path_names: { sign_in: 'login', sign_out: 'logout' }

  resources :users, only: [:show] do
    collection do
      get :select_plan
    end
    post :promo_code
    resources :children, except: [:index, :show]
  end

  resources :children, only: [:show] do
    ## subscriptions ##
    resources :subscriptions, only: [:new, :create, :show, :destroy]
  end

  resources :partners do
    resources :klasses, :schedules, except: [:index, :show]
  end

  get 'admin',                             to: 'admin#index'
  get 'admin/partners',                    to: 'admin#partners',         as: 'admin_partners'
  post 'admin/featured',                   to: 'admin#featured',         as: 'admin_featured'
  get 'admin/partners/:id',                to: 'admin#partner',          as: 'admin_partner'
  get 'admin/partners/:id/past_schedules', to: 'admin#past_schedules',   as: 'admin_partner_past_schedules'
  get 'admin/partners/:id/klasses',        to: 'admin#klasses',          as: 'admin_partner_klasses'
  get 'admin/schedules/:id',               to: 'admin#schedule',         as: 'admin_schedule'
  get 'admin/users',                       to: 'admin#users'
  get 'admin/settings',                    to: 'admin#settings'

  match 'users/:id' => 'users#destroy', via: :delete, as: 'admin_destroy_user'

  resources :cities, path: 'city', except: [:index, :show]
  resources :activities, except: [:index, :show]

  # Admin's Devise settings
  devise_for :admins, path: 'admin', path_names: { sign_in: 'login', sign_out: 'logout' }

  as :admin do
    get   'admin/profile', to: 'devise/registrations#edit',   as: :admin_root
    patch 'admin/:id',     to: 'devise/registrations#update', as: 'admin_registration'
  end


  ## cards ##
  resources :cards
end
