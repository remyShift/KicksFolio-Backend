Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post "/login", to: "authentication#login"
      delete "/logout", to: "authentication#logout"
      post "/verify_token", to: "authentication#verify_token"

      get '/upc_lookup', to: 'upc#lookup'
      get '/sku_lookup', to: 'sku#lookup'

      get "/users/me", to: "users#me"
      get "/users/me/collection", to: "users#collection"
      get "/users/me/sneakers", to: "users#sneakers"

      resources :friendships, only: [ :create, :destroy ] do
        member do
          patch :accept
          patch :decline
          patch :block
          delete :destroy
        end
      end

      resources :users, only: [ :create, :destroy, :update, :index, :show ] do
        resource :collection, only: [ :create, :show, :destroy, :update ] do
          get "friends", on: :collection, to: "collections#all_friends_collections"
          get "friends/:friend_id", on: :collection, to: "collections#friend_collection"

          resources :sneakers, only: [ :create, :index, :destroy, :update ]
        end
      end

      post '/passwords/forgot', to: 'passwords#forgot'
      post '/passwords/reset', to: 'passwords#reset'
    end
  end
end
