FactoryBot.define do
  factory :sneaker do
    brand { "Nike" }
    model { "Air Force 1" }
    size { 9 }
    purchase_date { Date.today }
    purchase_price { 100 }
    condition { 10 }
    estimated_value { 150 }
  end
end