require 'rest-client'

class Api::V1::SkuController < ApplicationController
  before_action :authorize_request

  def lookup
    begin
      response = RestClient.get(
        "https://the-sneaker-database.p.rapidapi.com/sneakers?limit=10&sku=#{params[:sku]}",
        {
          'X-RapidAPI-Key' => ENV['RAPIDAPI_KEY'],
          'X-RapidAPI-Host' => 'the-sneaker-database.p.rapidapi.com'
        }
      )
      
      render json: response.body, status: :ok
    rescue RestClient::ExceptionWithResponse => e
      render json: { error: "Error when searching for SKU #{params[:sku]} - #{e.message}" }, status: :bad_request
    end
  end
end