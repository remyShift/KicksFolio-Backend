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
    user = build(:user)
    user.sneaker_size = 10.5
    expect(user).to be_valid
    
    user.sneaker_size = 10.6
    expect(user).not_to be_valid
  end

  describe "profile picture validations" do
    let(:user) { build(:user) }
    let(:image) do
      Rack::Test::UploadedFile.new(
        Rails.root.join('spec', 'fixtures', 'files', 'sneaker.jpg'),
        'image/jpeg'
      )
    end
    
    it "is valid without a profile picture" do
      expect(user).to be_valid
    end

    it "is invalid with wrong content type" do
      allow(image).to receive(:content_type).and_return('application/pdf')
      user.profile_picture.attach(image)
      expect(user).not_to be_valid
      expect(user.errors[:profile_picture]).to include("has an invalid content type")
    end
  end
end
