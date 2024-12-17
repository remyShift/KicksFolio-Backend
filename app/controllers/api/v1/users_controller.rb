class API::V1::UsersController < ApplicationController

  def create
  end

  private

  def user_params
    params.require(:user).permit(:email, :password_digest, :username, :first_name, :last_name, :sneaker_size, :gender)
  end
end
