Rails.application.routes.draw do

  resources :lightnings do
    post :updateanswer, on: :collection, as: :updateanswer
    collection do
      get '/vote' => 'lightnings#vote', as: :lightningvote
      post 'thumbsup'
      post 'thumbsdown'
      post 'heart'
      post 'switchplayvote'
    end
  end

  resources :gamechats
  resources :games
  resources :games do
    collection do
      get '/:id/gamechat' => 'games#gamechat', as: :gamechat
      post 'sendemail'
      post 'seenresults'
      post 'resetnotice'
    end
  end

  resources :memberships
  resources :gamedata do
    post :updateanswer, on: :collection, as: :updateanswer
    post :vote, on: :collection, as: :vote
  end

  resources :groups
  resources :groups do
    collection do
      get '/:id/showmembers' => 'groups#showmembers', as: :showmembers
    end
  end

  resources :chats

  # devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks"}

  authenticated :user do
    root :to => 'pages#main', as: :authenticated_root
  end

  # You can have the root of your site routed with "root"
  root 'pages#landing'

  resources :pages do
    collection do
      get 'main' => 'pages#main'
      get 'rankings' => 'pages#rankings'
      get 'howtoplay' => 'pages#howtoplay'
      post 'tipsoff'
      post 'tipson'
    end
  end

  match 'main' => 'pages#main', via: [:get, :post]

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
