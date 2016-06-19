Rails.application.routes.draw do

  # get 'shop/index'

  devise_for :users
  devise_for :admin
  root to: "shop#index"

  resources :admin, only: :index
  namespace :admin do
    resources :goods
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


  resources :cart, only: :index do 
    patch :recalculate, on: :collection
    get :checkout, on: :collection
  end

  resources :cart_item, only: :destroy, defaults: { format: 'js' }

  resources :goods
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
