class Sneaker < ApplicationRecord
  belongs_to :collection
  has_many_attached :images

  validates :brand, :model, :size, :condition, presence: true
  validates :collection_id, presence: true
  validates :images, presence: true
end
