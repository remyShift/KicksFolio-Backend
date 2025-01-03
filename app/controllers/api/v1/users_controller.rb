class Api::V1::UsersController < ApplicationController
  before_action :authorize_request, only: [:me, :collection, :sneakers]

  def create
    user = User.new(user_params)

    if params[:user][:profile_picture].present?
      user.profile_picture.attach(params[:user][:profile_picture])
    end

    if user.save
      render json: { 
        message: "User created", 
        user: user.as_json(
          only: [:id, :email, :username, :first_name, :last_name, :sneaker_size, :created_at, :updated_at]
        ).merge(
          profile_picture_url: user.profile_picture.attached? ? url_for(user.profile_picture) : nil
        )
      }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def index
    users = User.all
    render json: { 
      users: users.as_json(
        only: [:id, :email, :username, :first_name, :last_name, :sneaker_size, :created_at, :updated_at]
      ) 
    }, status: :ok
  end

  def show
    user = User.find(params[:id])
    render json: {
      user: user_json(user)
    }, status: :ok
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
      if params[:user][:profile_picture].present?
        user.profile_picture.attach(params[:user][:profile_picture])
      end

      if user.update(user_params)
        render json: {
          user: user_json(user)
        }, status: :ok
      else
        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { errors: "User not found" }, status: :not_found
    end
  end

  def me
    user = @current_user

    if user
      render json: { 
        user: {
          id: user.id,
          email: user.email,
          username: user.username,
          first_name: user.first_name,
          last_name: user.last_name,
          sneaker_size: user.sneaker_size,
          created_at: user.created_at,
          updated_at: user.updated_at,
          profile_picture_url: user.profile_picture.attached? ? url_for(user.profile_picture) : nil,
          friends: user.friends.map { |f| basic_user_json(f) },
          pending_friends: user.pending_friends.map { |f| basic_user_json(f) },
          blocked_friends: user.blocked_friends.map { |f| basic_user_json(f) }
        }
      }, status: :ok
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

  def user_json(user)
    {
      id: user.id,
      email: user.email,
      username: user.username,
      first_name: user.first_name,
      last_name: user.last_name,
      sneaker_size: user.sneaker_size,
      created_at: user.created_at,
      updated_at: user.updated_at,
      profile_picture_url: user.profile_picture.attached? ? url_for(user.profile_picture) : nil,
      friends: user.friends.map { |f| basic_user_json(f) },
      pending_friends: user.pending_friends.map { |f| basic_user_json(f) },
      blocked_friends: user.blocked_friends.map { |f| basic_user_json(f) }
    }
  end

  def basic_user_json(user)
    {
      id: user.id,
      username: user.username,
      first_name: user.first_name,
      last_name: user.last_name
    }
  end

  def user_params
    params.require(:user).permit(
      :email,
      :password,
      :username,
      :first_name,
      :last_name,
      :sneaker_size,
      :profile_picture
    )
  end
end
