FactoryBot.define do
  factory :user do
    email { "toto@example.com" }
    password { "Password123" }
    first_name { "John" }
    last_name { "Doe" }
    username { "johndoe" }
    sneaker_size { 9.5 }
  end

  factory :user2, class: User do
    email { "jane@example.com" }
    password { "Password123" }
    first_name { "Jane" }
    last_name { "Smith" }
    username { "janesmith" }
    sneaker_size { 8.0 }
  end

  factory :user3, class: User do
    email { "johndoe@example.com" }
    password { "Password123" }
    first_name { "John" }
    last_name { "Doe" }
    username { "totouser" }
    sneaker_size { 9.5 }
  end
end
