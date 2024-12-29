class Api::V1::UsersController < ApplicationController
  before_action :authorize_request, only: [:me]

  def create
    user = User.new(user_params)

    if user.save
      render json: { user: user }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def index
    users = User.all
    render json: { users: users }, status: :ok
  end

  def show
    user = User.find(params[:id])
    render json: { user: user }, status: :ok
  end

  def destroy
    user = User.find(params[:id])

    if user
      user.destroy
      head :no_content
    else
      render json: { errors: "User not found" }, status: :not_found
    end
  end

  def update
    user = User.find(params[:id])

    if user
      user.update(user_params)
      render json: { user: user }, status: :ok
    else
      render json: { errors: "User not found" }, status: :not_found
    end
  end

  def me
    user = @current_user

    if user
      render json: { user: user.as_json(except: [:password_digest]) }, status: :ok
    else
      render json: { error: "User not found" }, status: :not_found
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :username, :first_name, :last_name, :sneaker_size, :gender)
  end
end
