require 'rails_helper'

RSpec.describe "Sneakers", type: :request do
  let(:user) { create(:user) }
  let(:token) { JWT.encode({ sub: user.id, exp: 24.hours.from_now.to_i }, ENV["JWT_SECRET"], "HS256") }
  let(:headers) { { "Authorization" => "Bearer #{token}" } }
  let!(:collection) { create(:collection, user: user) }

  describe "POST /create" do
    it "creates a new sneaker in the users collection" do
      post "/api/v1/users/#{user.id}/collection/sneakers", 
        params: {
          sneaker: {
            model: "Air Jordan 1",
            brand: "Nike",
            size: 9.5,
            condition: 10
          }
        },
        headers: headers

      expect(response).to have_http_status(:created)
    end
  end

  describe "GET /index" do
    it "returns all sneakers in the users collection" do
      get "/api/v1/users/#{user.id}/collection/sneakers", headers: headers
      expect(response).to have_http_status(:ok)
      
      response_body = JSON.parse(response.body)
      expect(response_body["sneakers"].count).to eq(collection.sneakers.count)
    end
  end

  describe "DELETE /destroy" do
    it "deletes a sneaker from the users collection" do
      sneaker = create(:sneaker, collection: collection)
      delete "/api/v1/users/#{user.id}/collection/sneakers/#{sneaker.id}", headers: headers
      expect(response).to have_http_status(:no_content)
    end
  end
end
