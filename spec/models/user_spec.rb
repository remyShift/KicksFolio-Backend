require "rails_helper"

RSpec.describe User, type: :model do
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:sneaker_size) }
  it { should have_one(:collection) }
  it { should have_many(:sneakers).through(:collection) }

  it "validates uniqueness of email" do
    create(:user, email: "test@example.com", sneaker_size: 9)
    should validate_uniqueness_of(:email).case_insensitive
  end

  it "validates uniqueness of username" do
    create(:user, username: "test", sneaker_size: 9)
    should validate_uniqueness_of(:username)
  end

  it "validates format of email" do
    should allow_value("test@example.com").for(:email)
    should_not allow_value("invalid_email").for(:email)
  end


  it { should validate_length_of(:password).is_at_least(8) }
  it { should allow_value("Password1").for(:password) }
  it { should_not allow_value("password").for(:password) }
  it { should_not allow_value("Password").for(:password) }

  it "should have a sneaker size in increments of 0.5" do
    expect(build(:user, sneaker_size: 10.5)).to be_valid
    expect(build(:user, sneaker_size: 10.6)).not_to be_valid
  end
end
