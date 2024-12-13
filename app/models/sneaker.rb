class Sneaker < ApplicationRecord
  has_many :collections

  validates :brand, :model, :size, :purchase_date, :purchase_price, :condition, presence: true
end
