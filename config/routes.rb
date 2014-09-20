Voucherdonor::Application.routes.draw do
  
  devise_for :users

  resources :friends
  resources :coupons
  resources :authentications
  resources :notifications
  root :to => "homes#index"

  # match "/admin" => "", :as => :admin
  
  match '/auth/:provider' => 'authentications#create_social_auth', :as => "social_auth"
  match '/auth/failure' => 'authentications#third_party_auth'
  match '/auth/:provider/callback' => 'authentications#create_social_auth'

  devise_scope :user do
    get "/login" => "devise/sessions#new"
  end

  match "/post_login" => "homes#post_login", :as => "post_login"
  
  # Real time updates api
  match '/create_real_time_subscription' => 'notifications#register_realtime_updates'
  match '/callback_url_facebook' => 'notifications#callback_fb', :as => 'callback_fb'
  match '/test' => 'notifications#test'
  match '/send_notification' => 'notifications#send_notification'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

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
