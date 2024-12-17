class Api::V1::UsersController < ApplicationController

  def create
    user = User.new(user_params)

    if user.save
      render json: { user: user }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :username, :first_name, :last_name, :sneaker_size, :gender)
  end
end
