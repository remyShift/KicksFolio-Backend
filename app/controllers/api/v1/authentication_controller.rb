class Api::V1::AuthenticationController < ApplicationController
  require "jwt"

  before_action :authorize_request, only: [ :logout, :verify_token ]

  REMEMBER_ME_EXPIRATION = 60.days.to_i
  DEFAULT_EXPIRATION = 2.days.to_i

  def login
    user = User.find_by(email: authenticate_params[:email].downcase)

    if user&.authenticate(authenticate_params[:password])
      exp = authenticate_params[:remember_me] ? REMEMBER_ME_EXPIRATION : DEFAULT_EXPIRATION
      token = JWT.encode({
        sub: user.id,
        exp: Time.now.to_i + exp
      }, ENV["JWT_SECRET"], "HS256")

      render json: {
        user: user.as_json(
          only: [:id, :email, :username, :first_name, :last_name, :sneaker_size, :created_at, :updated_at]
        ),
        token: token
      }, status: :ok
    else
      render json: { error: "Invalid email or password" }, status: :unauthorized
    end
  end

  def logout
    token = request.headers["Authorization"].split(" ").last
    decoded = JWT.decode(token, ENV["JWT_SECRET"], true, algorithm: "HS256")

    InvalidToken.create!(
      token: token,
      exp: Time.at(decoded[0]["exp"])
    )

    render json: { message: "Successfully logged out" }, status: :ok
  end

  def verify_token
    render json: {
      valid: true,
      user: @current_user.as_json(
        only: [:id, :email, :username, :first_name, :last_name, :sneaker_size, :created_at, :updated_at]
      )
    }, status: :ok
  rescue JWT::ExpiredSignature
    render json: { valid: false, error: "Token expiré" }, status: :unauthorized
  rescue JWT::DecodeError
    render json: { valid: false, error: "Token invalide" }, status: :unauthorized
  end

  private

  def authenticate_params
    params.require(:authentication).permit(:email, :password)
  end
end
