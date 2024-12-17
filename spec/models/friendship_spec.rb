require 'rails_helper'

RSpec.describe "Friendships", type: :request do
  let(:user) { create(:user) }
  let(:friend) { create(:user2) }

  it "creates a friendship request" do
    friendship = Friendship.create(user: user, friend: friend)
    expect(friendship.status).to eq("pending")
  end

  it "accepts a friendship request" do
    friendship = Friendship.create(user: user, friend: friend)
    friendship.accept
    expect(friendship.status).to eq("accepted")
  end

  it "declines a friendship request" do
    friendship = Friendship.create(user: user, friend: friend)
    friendship.decline
    expect(friendship.status).to eq("declined")
  end

  it "block a user" do
    friendship = Friendship.create(user: user, friend: friend)
    friendship.block
    expect(friendship.status).to eq("blocked")
  end
end
