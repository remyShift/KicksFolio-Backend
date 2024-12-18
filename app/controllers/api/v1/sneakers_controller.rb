class Api::V1::SneakersController < ApplicationController
  include Rails.application.routes.url_helpers

  before_action :authorize_request
  before_action :set_current_user
  before_action :set_collection

  def create
    sneaker = Sneaker.new(sneaker_params.merge(collection_id: @collection.id))

    if sneaker.save
      render json: {
        sneaker: sneaker.as_json.merge(
          images: sneaker.images.map { |image|
            {
              url: url_for(image)
            }
          }
        )
      }, status: :created
    else
      render json: { errors: sneaker.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    render json: { error: "Invalid file format or corrupted file" }, status: :unprocessable_entity
  end

  def index
    sneakers = Sneaker.where(collection_id: @collection.id)

    if sneakers.nil?
      render json: { errors: "No sneakers in this collection" }, status: :not_found
    else
      render json: { sneakers: sneakers }, status: :ok
    end
  end

  def destroy
    sneaker = Sneaker.find(params[:id])

    if sneaker
      sneaker.destroy
      head :no_content
    else
      render json: { errors: "Sneaker not found" }, status: :not_found
    end
  end

  def update
    sneaker = Sneaker.find(params[:id])

    if sneaker
      sneaker.update(sneaker_params)
      render json: { sneaker: sneaker }, status: :ok
    else
      render json: { errors: "Sneaker not found" }, status: :not_found
    end
  end

  private

  def sneaker_params
    params.require(:sneaker).permit(:model, :brand, :size, :condition, images: [])
  end

  def set_current_user
    @current_user = User.find(params[:user_id])
  end

  def set_collection
    @collection = Collection.find_by(user_id: @current_user.id)
  end
end
