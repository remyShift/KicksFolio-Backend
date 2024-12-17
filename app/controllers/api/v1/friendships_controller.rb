class Api::V1::FriendshipsController < ApplicationController
  before_action :authorize_request

  def create
    @friendship = @current_user.friendships.build(friend_id: params[:friend_id])

    if @friendship.save
      render json: { message: "Friend request sent." }, status: :created
    else
      render json: { errors: @friendship.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_friendship
    @friendship = Friendship.find(params[:id])
  end

  def set_current_user
    @current_user = User.find(params[:user_id])
  end
end
