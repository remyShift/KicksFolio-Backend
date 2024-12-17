FactoryBot.define do
  factory :user do
    email { "toto@example.com" }
    password { "Password123" }
    first_name { "John" }
    last_name { "Doe" }
    username { "totouser" }
    sneaker_size { 9.5 }
    gender { "male" }
  end
end
