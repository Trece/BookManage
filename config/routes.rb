BookManage::Application.routes.draw do


  match '/' => 'lib_manage#home', as: :home
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  get '/admin/', to: 'admin#index', as: :admin
  get '/admin/status/', to: 'admin#status', as: :admin_status
  get '/admin/transfer/', to: 'admin#find_book', as: :admin_find_book
  get '/admin/transfer/:id', to: 'admin#transfer', as: :admin_transfer
  
  resources :books, only: [:index, :show] do
    member do
      post 'borrow_book', as: :borrow
      post 'return_book', as: :return
      post 'reserve_book', as: :reserve
      post 'unreserve_book', as: :unreserve
    end
    collection do
      post 'search'
    end
  end

  resources :readers, only: [:index, :show, :edit, :update]


  resources :users, only: :index do
    member do
      get 'logout'
    end
  end

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
