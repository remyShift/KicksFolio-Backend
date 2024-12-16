require "rails_helper"

RSpec.describe Sneaker, type: :model do
  it { should validate_presence_of(:model) }
  it { should validate_presence_of(:brand) }
  it { should validate_presence_of(:size) }
  it { should validate_presence_of(:condition) }
  it { should belong_to(:collection) }
end
