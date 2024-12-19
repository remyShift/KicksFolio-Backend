require 'rails_helper'

RSpec.describe "Collections", type: :request do
  let(:user) { create(:user) }
  let(:token) { JWT.encode({ sub: user.id, exp: 24.hours.from_now.to_i }, ENV["JWT_SECRET"], "HS256") }
  let(:headers) { { "Authorization" => "Bearer #{token}" } }
  let(:collection) { create(:collection, user: user) }
  let(:friend) { create(:user2) }

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

  describe "PATCH /api/v1/users/:id/collection" do
    it "updates a collection" do
      collection = create(:collection, user: user)

      patch "/api/v1/users/#{user.id}/collection",
        params: {
          collection: {
            name: "Test Toto"
          }
        },
        headers: headers

      expect(response).to have_http_status(:ok)
      expect(collection.reload.name).to eq("Test Toto")
    end
  end

  describe "GET /friends" do
    let(:friend1) { create(:user3) }

    before do
      user.friendships.create(friend_id: friend.id)
      friend.received_friendships.last.accept
      user.friendships.create(friend_id: friend1.id)
      friend1.received_friendships.last.accept

      create(:collection, user: friend, name: "Collection Ami 1")
      create(:collection, user: friend1, name: "Collection Ami 2")
    end

    it "returns all collections from friends" do
      get "/api/v1/users/#{user.id}/collection/friends", headers: headers

      expect(response).to have_http_status(:ok)
      response_body = JSON.parse(response.body)

      expect(response_body["friends_collections"].length).to eq(2)
      expect(response_body["friends_collections"].first["friend"]["username"]).to eq(friend.username)
      expect(response_body["friends_collections"].first["collection"]["name"]).to eq("Collection Ami 1")
    end

    it "returns empty array if user has no friends" do
      new_user = create(:user3, email: "newuser@example.com", password: "Password123", first_name: "New", last_name: "User", username: "newuser")
      new_token = JWT.encode({ sub: new_user.id, exp: 24.hours.from_now.to_i }, ENV["JWT_SECRET"], "HS256")
      new_headers = { "Authorization" => "Bearer #{new_token}" }

      get "/api/v1/users/#{new_user.id}/collection/friends", headers: new_headers

      expect(response).to have_http_status(:ok)
      response_body = JSON.parse(response.body)
      expect(response_body["friends_collections"]).to be_empty
    end
  end

  describe "GET /friends/:friend_id" do
    let(:friend1) { create(:user2) }

    before do
      user.friendships.create(friend_id: friend1.id)
      friend1.received_friendships.last.accept
      create(:collection, user: friend1, name: "Collection Ami 1")
    end

    it "returns a specific friend's collection" do
      get "/api/v1/users/#{user.id}/collection/friends/#{friend1.id}", headers: headers

      expect(response).to have_http_status(:ok)
      response_body = JSON.parse(response.body)

      expect(response_body["friend_collection"]["friend"]["id"]).to eq(friend1.id)
      expect(response_body["friend_collection"]["collection"]["name"]).to eq("Collection Ami 1")
    end

    it "returns unauthorized if users are not friends" do
      non_friend = create(:user3)

      get "/api/v1/users/#{user.id}/collection/friends/#{non_friend.id}", headers: headers

      expect(response).to have_http_status(:unauthorized)
    end
  end
end
