require "rails_helper"

RSpec.describe "Friendships", type: :request do
  let(:user) { create(:user) }
  let(:friend) { create(:user2) }
  let(:headers) { { "Authorization" => "Bearer #{token}" } }
  let(:token) { JWT.encode({ sub: user.id, exp: 24.hours.from_now.to_i }, ENV["JWT_SECRET"], "HS256") }

  describe "POST /friendships" do
    it "sends a friend request" do
      post "/api/v1/friendships", params: { friend_id: friend.id }, headers: headers
      expect(response).to have_http_status(:created)
    end
  end
end