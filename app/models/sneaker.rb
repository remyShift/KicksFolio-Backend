class Sneaker < ApplicationRecord
  has_many :collections

  validates :brand, :model, :size, :condition, presence: true
end
