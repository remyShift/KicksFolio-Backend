class Sneaker < ApplicationRecord
  belongs_to :collection
  has_many_attached :photos

  validates :brand, :model, :size, :condition, presence: true
  validates :collection_id, presence: true
end
