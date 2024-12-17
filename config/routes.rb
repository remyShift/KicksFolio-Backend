Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post "/login", to: "authentication#login"
      delete "/logout", to: "authentication#logout"

      resources :friendships, only: [:create] do
        member do
          patch :accept
        end
      end

      resources :users, only: [:create, :destroy, :update, :index] do
        resource :collection, only: [:create, :show, :destroy, :update] do
          resources :sneakers, only: [:create, :index, :destroy, :update]
        end
      end
    end
  end
end
