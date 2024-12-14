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
end
