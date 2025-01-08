class Api::V1::UpcController < ApplicationController
  before_action :authorize_request

  def lookup
    begin
      response = RestClient.get(
        "https://api.barcodelookup.com/v3/products?barcode=#{params[:barcode]}&formatted=y&key=#{ENV['UPC_API_KEY']}"
      )
      
      render json: response.body, status: :ok
    rescue RestClient::ExceptionWithResponse => e
      render json: { error: "Error when searching for barcode #{params[:barcode]} - #{e.message}" }, status: :bad_request
    end
  end
end