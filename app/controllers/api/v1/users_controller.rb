class Api::V1::UsersController < ApplicationController
  before_action :authorize_request, only: [:me, :collection, :sneakers]

  def create
    user = User.new(user_params)

    if user.save
      render json: { message: "User created", user: user }, status: :created
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

  def collection
    user = @current_user

    if user
      render json: { collection: user.collection }, status: :ok
    else
      render json: { error: "User not found" }, status: :not_found
    end
  end

  def sneakers
    user = @current_user

    if user
      render json: { sneakers: user.sneakers }, status: :ok
    else
      render json: { error: "User not found" }, status: :not_found
    end
  end

  def destroy_all
    User.destroy_all
    render json: { message: "All users deleted" }, status: :ok
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :username, :first_name, :last_name, :sneaker_size)
  end
end
