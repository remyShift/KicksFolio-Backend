class Api::V1::CollectionsController < ApplicationController
  before_action :authorize_request
  before_action :set_current_user

  def show
    render json: { collection: Collection.find_by(user_id: @current_user.id) }, status: :ok
  end

  def create
    collection = Collection.new(collection_params.merge(user_id: @current_user.id))

    if collection.save
      render json: { collection: collection }, status: :created
    else
      render json: { errors: collection.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    collection = Collection.find_by(user_id: @current_user.id)

    if collection
      collection.destroy
      head :no_content
    else
      render json: { errors: "Collection not found" }, status: :not_found
    end
  end

  def update
    collection = Collection.find_by(user_id: @current_user.id)

    if collection
      collection.update(collection_params)
      render json: { collection: collection }, status: :ok
    else
      render json: { errors: "Collection not found" }, status: :not_found
    end
  end

  def friends_collections
    @current_user = User.find(params[:user_id])

    all_friends = @current_user.friends +
                  User.joins(:friendships)
                      .where(friendships: { friend_id: @current_user.id, status: "accepted" })

    if all_friends.empty?
      render json: { friends_collections: [] }, status: :ok
    else
      friends_collections = all_friends.uniq.map do |friend|
        {
          friend: {
            id: friend.id,
            username: friend.username,
            first_name: friend.first_name,
            last_name: friend.last_name
          },
          collection: friend.collection
        }
      end
      render json: { friends_collections: friends_collections }, status: :ok
    end
  end

  private

  def collection_params
    params.require(:collection).permit(:name)
  end

  def set_current_user
    @current_user = User.find(params[:user_id])
  end
end
