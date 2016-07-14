Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :contact_requests
  resources :zipcodes do
    collection do
      post :contact_request
    end
  end

  mount Bootsy::Engine => '/bootsy', as: 'bootsy'
  resources :static_page_contents
  resources :promo_codes
  get 'cards/new'

  root 'static_pages#index'

  get 'comming_soon', to: 'static_pages#comming_soon', as: 'comming_soon'
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
      get :new_referal_code
      post :check_referal_code
    end
    post :promo_code
    resources :children, except: [:index, :show]
  end

  resources :children, only: [:show] do
    ## subscriptions ##
    resources :subscriptions, only: [:new, :create, :show, :destroy]
  end

  resources :partners do
    collection do
      get :loadmore
    end
    resources :klasses, :schedules, except: [:index, :show]
  end

  # match 'users/:id' => 'users#destroy', via: :delete, as: 'admin_destroy_user'

  resources :cities, path: 'city', except: [:index, :show]
  resources :activities, except: [:index, :show]

  # Admin's Devise settings
  # devise_for :admins, path: 'admin', path_names: { sign_in: 'login', sign_out: 'logout' }

  ## cards ##
  resources :cards
end
