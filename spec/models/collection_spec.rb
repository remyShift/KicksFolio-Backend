require "rails_helper"

RSpec.describe Collection, type: :model do
  it { should belong_to(:user) }
  it { should have_many(:sneakers) }
  it { should validate_presence_of(:name) }
end
