class Api::V1::AuthenticationController < ApplicationController

  def login
    user = User.where(email: authenticate_params[:email])
    if (user.length != 1)
      render json: { error: "Invalid email or password" }, status: :unauthorized
    else
      user = user.first
      if user.authenticate(authenticate_params[:password])
        render json: { user: user }, status: :ok
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
