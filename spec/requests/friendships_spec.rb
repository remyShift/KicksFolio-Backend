require "rails_helper"

RSpec.describe "Friendships", type: :request do
  let(:user) { create(:user) }
  let(:friend) { create(:user2) }
  let(:token) { JWT.encode({ sub: friend.id, exp: 24.hours.from_now.to_i }, ENV["JWT_SECRET"], "HS256") }
  let(:headers) { { "Authorization" => "Bearer #{token}" } }

  let(:user3) { create(:user3) }
  let(:token3) { JWT.encode({ sub: user3.id, exp: 24.hours.from_now.to_i }, ENV["JWT_SECRET"], "HS256") }
  let(:headers3) { { "Authorization" => "Bearer #{token3}" } }

  describe "POST /friendships" do
    it "sends a friend request" do
      post "/api/v1/friendships", params: { friend_id: friend.id }, headers: headers
      expect(response).to have_http_status(:created)
    end
  end

  describe "PATCH /friendships/:id/accept" do
    let!(:friendship) { create(:friendship, user: user, friend: friend) }

    it "accepts a friend request" do
      patch "/api/v1/friendships/#{friendship.id}/accept", headers: headers
      expect(response).to have_http_status(:ok)
      expect(friendship.reload.status).to eq("accepted")
    end

    it "cannot accepts a friend request if the user who accepts is not the friend" do
      patch "/api/v1/friendships/#{friendship.id}/accept", headers: headers3
      expect(response).to have_http_status(:unauthorized)
      expect(friendship.reload.status).to eq("pending")
    end
  end

  describe "PATCH /friendships/:id/decline" do
    let!(:friendship) { create(:friendship, user: user, friend: friend) }

    it "declines a friend request" do
      patch "/api/v1/friendships/#{friendship.id}/decline", headers: headers
      expect(response).to have_http_status(:ok)
      expect(friendship.reload.status).to eq("declined")
    end

    it "cannot declines a friend request if the user who declines is not the friend" do
      patch "/api/v1/friendships/#{friendship.id}/decline", headers: headers3
      expect(response).to have_http_status(:unauthorized)
      expect(friendship.reload.status).to eq("pending")
    end
  end

  describe "PATCH /friendships/:id/block" do
    let!(:friendship) { create(:friendship, user: user, friend: friend) }

    it "blocks a friend request" do
      patch "/api/v1/friendships/#{friendship.id}/block", headers: headers
      expect(response).to have_http_status(:ok)
      expect(friendship.reload.status).to eq("blocked")
    end

    it "cannot blocks a friend request if the user who blocks is not the friend or the user" do
      patch "/api/v1/friendships/#{friendship.id}/block", headers: headers3
      expect(response).to have_http_status(:unauthorized)
      expect(friendship.reload.status).to eq("pending")
    end
  end

  describe "DELETE /friendships/:id" do
    let!(:friendship) { create(:friendship, user: user, friend: friend) }

    it "removes a friendship" do
      delete "/api/v1/friendships/#{friendship.id}", headers: headers
      expect(response).to have_http_status(:no_content)
      expect(Friendship.exists?(friendship.id)).to be_falsey
    end
  end
end
