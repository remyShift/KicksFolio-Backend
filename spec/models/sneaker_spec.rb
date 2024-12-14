require "rails_helper"

RSpec.describe Sneaker, type: :model do
  it "should be a valid factory" do
    expect(build(:sneaker)).to be_valid
  end

  it "should not be valid without a model name" do
    expect(build(:sneaker, model: nil)).not_to be_valid
  end

  it "should not be valid without a brand" do
    expect(build(:sneaker, brand: nil)).not_to be_valid
  end

  it "should not be valid without a size" do
    expect(build(:sneaker, size: nil)).not_to be_valid
  end

  it "should be valid if there is not a purchase date" do
    expect(build(:sneaker, purchase_date: nil)).to be_valid
  end

  it "should be valid if there is not a purchase price" do
    expect(build(:sneaker, purchase_price: nil)).to be_valid
  end

  it "should be valid if there is not an estimated value" do
    expect(build(:sneaker, estimated_value: nil)).to be_valid
  end

  it "should have a condition" do
    expect(build(:sneaker, condition: nil)).not_to be_valid
  end
end
