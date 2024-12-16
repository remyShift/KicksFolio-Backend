class ApplicationController < ActionController::API
        include DeviseTokenAuth::Concerns::SetUserByToken

        before_action :configure_permitted_parameters, if: :devise_controller?

        protected

        def configure_permitted_parameters
                sign_up_params = [ :first_name, :last_name, :pseudo, :sneaker_size, :gender,
                                :confirm_success_url, :email, :password, :password_confirmation ]
                sign_in_params = [ :email, :password ]
                devise_parameter_sanitizer.permit(:sign_up, keys: sign_up_params)
                devise_parameter_sanitizer.permit(:sign_in, keys: sign_in_params)
        end
end
