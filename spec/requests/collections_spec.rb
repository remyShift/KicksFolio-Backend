require 'rails_helper'

RSpec.describe "Collections", type: :request do
  let(:user) { create(:user) }
  let(:token) { JWT.encode({ sub: user.id, exp: 24.hours.from_now.to_i }, ENV["JWT_SECRET"], "HS256") }
  let(:headers) { { "Authorization" => "Bearer #{token}" } }
  let(:collection) { create(:collection, user: user) }

  describe "POST /create" do
    it "returns a successful response with a new collection for the current user" do
      post "/api/v1/users/#{user.id}/collection", 
        params: { 
          collection: { 
            name: "Test Collection" 
          } 
        }, 
        headers: headers

      expect(response).to have_http_status(:created)

      response_body = JSON.parse(response.body)
      expect(response_body["collection"]["name"]).to eq("Test Collection")
      expect(response_body["collection"]["user_id"]).to eq(user.id)
    end

    it "returns an error if the collection is not valid" do
      post "/api/v1/users/#{user.id}/collection", 
        params: { collection: { name: "" } }, 
        headers: headers
  
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "returns an error if the user already has a collection" do
      create(:collection, user: user)
      post "/api/v1/users/#{user.id}/collection", 
        params: { collection: { name: "Test Collection 2" } }, 
        headers: headers

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "GET /show" do
    it "returns a successful response with the current user's collection" do
      get "/api/v1/users/#{user.id}/collection", headers: headers
      expect(response).to have_http_status(:ok)
    end
  end

  describe "DELETE /destroy" do
    context "when collection exists" do
      before do
        collection
      end

      it "should delete the users collection" do
        delete "/api/v1/users/#{user.id}/collection", headers: headers
        expect(response).to have_http_status(:no_content)
      end
    end

    it "returns not found when collection doesn't exist" do
      delete "/api/v1/users/#{user.id}/collection", headers: headers
      expect(response).to have_http_status(:not_found)
    end
  end
end
