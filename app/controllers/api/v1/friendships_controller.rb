class Api::V1::FriendshipsController < ApplicationController
  before_action :authorize_request
  before_action :set_friendship, only: [ :accept, :decline, :block, :destroy ]
  before_action :check_friend, only: [ :accept, :decline ]
  before_action :check_friendship, only: [ :block, :destroy ]

  def create
    friendship = @current_user.friendships.build(friend_id: params[:friend_id])

    if friendship.save
      render json: { message: "Friend request sent.", friendship: friendship }, status: :created
    else
      render json: { errors: friendship.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def accept
    if @friendship
      @friendship.accept
      render json: { message: "Friend request accepted.", friendship: @friendship }, status: :ok
    else
      render json: { errors: @friendship.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def decline
    if @friendship
      @friendship.decline
      render json: { message: "Friend request declined.", friendship: @friendship }, status: :ok
    else
      render json: { errors: @friendship.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def block
    if @friendship
      @friendship.block
      render json: { message: "Friend request blocked.", friendship: @friendship }, status: :ok
    else
      render json: { errors: @friendship.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @friendship
      @friendship.destroy
      head :no_content
    else
      render json: { errors: @friendship.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_friendship
    @friendship = Friendship.find(params[:id])
  end

  def check_friend
    if @friendship.friend.id != @current_user.id
      render json: { errors: "You are not authorized to perform this action." }, status: :unauthorized
    end
  end

  def check_friendship
    if @friendship.user.id != @current_user.id && @friendship.friend.id != @current_user.id
      render json: { errors: "You are not authorized to perform this action." }, status: :unauthorized
    end
  end
end
