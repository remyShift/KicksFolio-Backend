FactoryBot.define do
  factory :friendship do
    association :user
    association :friend
    status { "pending" }
  end
end