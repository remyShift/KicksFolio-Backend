require "rails_helper"

RSpec.describe Collection, type: :model do
  it "should be a valid factory (initialized with correct values)" do
    expect(build(:collection)).to be_valid
    expect(build(:collection, user: nil)).not_to be_valid
    expect(build(:collection, sneaker: nil)).not_to be_valid
    expect(build(:collection, name: nil)).not_to be_valid
  end

  it "should be valid if there is a duplicate sneaker" do
    collection = create(:collection)
    expect(build(:collection, sneaker: collection.sneaker)).to be_valid
  end

  it "should not allow a user to have multiple collections" do
    collection = create(:collection)
    collection2 = build(:collection, user: collection.user)
    expect(collection2).not_to be_valid
  end
end

