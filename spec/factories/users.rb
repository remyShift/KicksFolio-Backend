FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { "Password1" }
    first_name { "John" }
    last_name { "Doe" }
    pseudo { "johndoe" }
    sneaker_size { 9.5 }
    gender { "male" }
  end
end
