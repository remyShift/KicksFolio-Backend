FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { "password" }
    first_name { "John" }
    last_name { "Doe" }
    pseudo { "johndoe" }
    sneaker_size { 9 }
  end
end
