class Sneaker < ApplicationRecord
  belongs_to :collection

  validates :brand, :model, :size, :condition, presence: true
  validates :collection_id, presence: true, uniqueness: true
end
