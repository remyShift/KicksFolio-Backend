FactoryBot.define do
  factory :sneaker do
    model { "Air Jordan 1" }
    brand { "Nike" }
    size { 9.5 }
    condition { 9 }
    status { "rocking" }
    association :collection

    trait :with_images do
      after(:build) do |sneaker|
        sneaker.images.attach(
          io: StringIO.new(File.read(Rails.root.join('spec', 'fixtures', 'files', 'sneaker.jpg'))),
          filename: 'sneaker.jpg',
          content_type: 'image/jpeg'
        )
      end
    end
  end
end
