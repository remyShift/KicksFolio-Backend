require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { create(:user) }
  let(:friend) { create(:user2) }
  let(:token) { JWT.encode({ sub: user.id, exp: 24.hours.from_now.to_i }, ENV["JWT_SECRET"], "HS256") }
  let(:headers) { { "Authorization" => "Bearer #{token}" } }

  describe "POST /api/v1/users" do
    let(:user_params) {
      {
        user: {
          email: "test@example.com",
          password: "Password123",
          username: "testuser",
          first_name: "John",
          last_name: "Doe",
          sneaker_size: 10,
          gender: "male"
        }
      }
    }

    it "creates a new user" do
      post "/api/v1/users", params: user_params
      expect(response).to have_http_status(:created)
    end
  end

  describe "POST api/v1/login" do
    it "logs in a user" do
      post "/api/v1/login", params: {
        authentication: {
          email: user.email,
          password: "Password123",
          remember_me: false
        }
      }
      expect(response).to have_http_status(:ok)
    end
  end

  describe "DELETE api/v1/logout" do
    it "logs out a user" do
      delete "/api/v1/logout", headers: headers
      expect(response).to have_http_status(:ok)
    end
  end

  describe "DELETE api/v1/users/:id" do
    it "deletes a user" do
      delete "/api/v1/users/#{user.id}", headers: headers
      expect(response).to have_http_status(:no_content)
    end

    it "returns an error if the user is not found" do
      delete "/api/v1/users/9999", headers: headers
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "PATCH api/v1/users/:id" do
    it "updates a user" do
      patch "/api/v1/users/#{user.id}", params: {
        user: {
          email: "test2@example.com",
          password: "Password1234",
          username: "testuser2",
          first_name: "Jane",
          last_name: "Doe",
          sneaker_size: 11,
          gender: "female"
        }
      }, headers: headers
      expect(response).to have_http_status(:ok)
      expect(user.reload.email).to eq("test2@example.com")
      expect(user.reload.username).to eq("testuser2")
      expect(user.reload.first_name).to eq("Jane")
      expect(user.reload.last_name).to eq("Doe")
      expect(user.reload.sneaker_size).to eq(11)
      expect(user.reload.gender).to eq("female")
    end
  end

  describe "GET api/v1/users/:id" do
    it "returns a user" do
      get "/api/v1/users/#{user.id}", headers: headers
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET api/v1/users/:id" do
    before do
      user.friendships.create(friend_id: friend.id)
      friend.received_friendships.last.accept
    end

    it "returns the friend of a user" do
      get "/api/v1/users/#{user.id}", headers: headers
      expect(response).to have_http_status(:ok)
      expect(user.friends).to eq([ friend ])
      expect(friend.friends).to eq([ user ])
    end
  end

  describe "GET api/v1/users/:id" do
    before do
      user.friendships.create(friend_id: friend.id)
      friend.received_friendships.last.block
    end

    it "returns the blocked user of a user" do
      get "/api/v1/users/#{user.id}", headers: headers
      expect(response).to have_http_status(:ok)
      expect(user.blocked_friends).to eq([ friend ])
      expect(friend.blocked_friends).to eq([ user ])
    end
  end

  describe "GET api/v1/users/:id" do
    before do
      user.friendships.create(friend_id: friend.id)
    end

    it "returns the pending friendship of a user" do
      get "/api/v1/users/#{user.id}", headers: headers
      expect(response).to have_http_status(:ok)
      expect(user.pending_friends).to eq([ friend ])
    end
  end
end
