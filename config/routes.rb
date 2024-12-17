Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post "/login", to: "authentication#login"
      delete "/logout", to: "authentication#logout"
      resources :users, only: [:create]
    end
  end
end
