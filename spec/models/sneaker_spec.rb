require "rails_helper"

RSpec.describe Sneaker, type: :model do
  it "should be a valid factory (initialized with correct values)" do
    expect(build(:sneaker)).to be_valid
    expect(build(:sneaker, model: nil)).not_to be_valid
    expect(build(:sneaker, brand: nil)).not_to be_valid
    expect(build(:sneaker, size: nil)).not_to be_valid
    expect(build(:sneaker, condition: nil)).not_to be_valid

    expect(build(:sneaker, purchase_date: nil)).to be_valid
    expect(build(:sneaker, purchase_price: nil)).to be_valid
    expect(build(:sneaker, estimated_value: nil)).to be_valid
  end
end
