Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post "/login", to: "authentication#login"
      delete "/logout", to: "authentication#logout"

      resources :users, only: [:create, :destroy, :update] do
        resource :collection, only: [:create, :show, :destroy, :update] do
          resources :sneakers, only: [:create, :index, :destroy, :update]
        end
      end
    end
  end
end
