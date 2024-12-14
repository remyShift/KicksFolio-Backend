require "rails_helper"

RSpec.describe User, type: :model do
  it "has a valid factory" do
    expect(build(:user)).to be_valid
  end

  it "is valid with all attributes" do
    expect(build(:user)).to be_valid
  end

  it "is not valid without an email" do
    expect(build(:user, email: nil)).not_to be_valid
  end

  it "is not valid without a password" do
    expect(build(:user, password: nil)).not_to be_valid
  end

  it "is not valid without a first name" do
    expect(build(:user, first_name: nil)).not_to be_valid
  end

  it "is not valid without a last name" do
    expect(build(:user, last_name: nil)).not_to be_valid
  end

  it "is not valid without a pseudo" do
    expect(build(:user, pseudo: nil)).not_to be_valid
  end

  it "is not valid without a sneaker size" do
    expect(build(:user, sneaker_size: nil)).not_to be_valid
  end

  it "is not valid with a duplicate email" do
    create(:user, email: "test@example.com")
    expect(build(:user, email: "test@example.com")).not_to be_valid
  end

  it "is not valid with a duplicate pseudo" do
    create(:user, pseudo: "test")
    expect(build(:user, pseudo: "test")).not_to be_valid
  end

  it "is not valid with invalid email format" do
    expect(build(:user, email: "invalid-email")).not_to be_valid
  end

  it 'should have only one collection' do
    user = create(:user)
    sneaker = create(:sneaker)
    create(:collection, user: user, sneaker: sneaker)

    expect(user.collection).not_to be_nil
    expect { create(:collection, user: user, sneaker: sneaker) }.to raise_error(ActiveRecord::RecordInvalid)
  end
end
