FactoryBot.define do
  factory :collection do
    name { "My First Collection" }
    association :user
    association :sneaker
  end
end