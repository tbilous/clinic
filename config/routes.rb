Rails.application.routes.draw do

  resources :pharms

  get 'pharm_owners/create'

  get 'pharm_owners/destroy'

  get 'pharm_types/create'

  get 'pharm_types/destroy'

  get 'pharm_groups/create'

  get 'pharm_groups/destroy'

  devise_for :admins
  devise_for :users
  get 'users/show', as: 'user_root'
  resources :users
  resources :characters, only: [:new, :create, :destroy, :update, :edit, :show]
  resources :contacts, only: [:new, :create, :destroy, :update, :edit, :show, :index]
  resources :anthropometries, only: [:create, :destroy, :index]

  root  'static_pages#home'

  post 'characters/activate' => 'characters#activate'

  match '/users/:id',   to: 'users#show',         via: 'get'
  match '/edit',        to: 'users#edit',         via: 'get'
  match '/index',       to: 'users#index',        via: 'get'
  match '/signup',      to: 'users#new',          via: 'get'
  match '/about',       to: 'static_pages#about', via: 'get'

  get 'avatar/:size/:background/:text' => Dragonfly.app.endpoint { |params, app|
  app.generate(:initial_avatar, URI.unescape(params[:text]), { size: params[:size], background_color: params[:background] })
}, as: :avatar

  # scope "/:locale" do
  #   resources :static_pages
  # end
  # scope "(:locale)", locale: /en|uk/ do
  #   resources :static_pages
  # end
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
