FactoryBot.define do
  factory :sneaker do
    model { "Air Jordan 1" }
    brand { "Nike" }
    size { 9.5 }
    condition { 9 }
    status { "rocking" }
    images { [Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/sneaker.jpg'), 'image/jpeg')] }
    association :collection
  end
end
