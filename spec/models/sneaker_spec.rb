require "rails_helper"

RSpec.describe Sneaker, type: :model do
  let(:collection) { create(:collection) }

  it { should validate_presence_of(:model) }
  it { should validate_presence_of(:brand) }
  it { should validate_presence_of(:size) }
  it { should validate_presence_of(:condition) }
  it { should validate_presence_of(:status) }
  it { should belong_to(:collection) }
  it { should validate_numericality_of(:size).is_greater_than(7).is_less_than(16) }
  it { should validate_numericality_of(:condition).is_greater_than_or_equal_to(1).is_less_than_or_equal_to(10) }
  it { should validate_presence_of(:images) }
end
