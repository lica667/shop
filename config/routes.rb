Rails.application.routes.draw do

  # get 'shop/index'

  devise_for :users, path: 'account', controllers: { sessions: 'users/sessions' }
  devise_for :admin#, controllers: { sessions: 'admin/sessions' }

  root to: "shop#index"

  resources :admin, only: :index
  namespace :admin do
    resources :goods
    resources :orders, only: :index do
      get :change_state
    end
    resources :categories
    resources :users do
      collection do
        get 'diactivate'
        get 'activate'
      end
    end
  end
  get '/category',          to: 'shop#category'
  get '/goods/:id',         to: 'shop#show'
  get '/categories',        to: 'shop#categories'
  get '/change_currency',   to: 'shop#change_currency'
  get 'admin/update_costs', to: 'admin#update_costs'
  post '/add_to_cart',      to: 'shop#add_to_cart'


  resources :cart, only: [:index, :update] do 
    patch :recalculate, on: :collection
    get :checkout, on: :collection
    patch :order
  end

  resources :cart_item, only: :destroy, defaults: { format: 'js' }

  resources :goods
  namespace :users do
    get :account
    get :addresses
    get :orders
    get :change_account
    patch :update_account
  end
  
end
