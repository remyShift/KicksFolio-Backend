FactoryBot.define do
  factory :collection do
    name { "My First Collection" }
    association :user
  end
end
