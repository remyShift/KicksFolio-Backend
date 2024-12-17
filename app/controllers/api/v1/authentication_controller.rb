class Api::V1::AuthenticationController < ApplicationController
  require "jwt"

  REMEMBER_ME_EXPIRATION = 60.days.to_i
  DEFAULT_EXPIRATION = 2.days.to_i

  def login
    user = User.find_by(email: authenticate_params[:email].downcase)

    if user.nil?
      render json: { error: "Invalid email or password" }, status: :unauthorized
    else
      if user.authenticate(authenticate_params[:password])
        exp = authenticate_params[:remember_me] ? REMEMBER_ME_EXPIRATION : DEFAULT_EXPIRATION

        token = JWT.encode({
          sub: user.id,
          exp: Time.now.to_i + exp
        }, ENV["JWT_SECRET"], "HS256")

        render json: { 
          user: user.as_json(except: [:password_digest]), 
          token: token 
        }, status: :ok
      else
        render json: { error: "Invalid email or password" }, status: :unauthorized
      end
    end
  end

  def logout
  end

  private

  def authenticate_params
    params.require(:authentication).permit(:email, :password)
  end
end
