class Sneaker < ApplicationRecord
  belongs_to :collection
  has_many_attached :images

  STATUS = ['rocking', 'stocking', 'selling']

  validates :brand, :model, :size, :condition, :status, presence: true
  validates :sneaker_size_valid?, presence: true, numericality: { greater_than: 7, less_than: 16 }
  validates :collection_id, presence: true
  validates :images, presence: true

  validate :status_inclusion

  def status_inclusion
    unless STATUS.include?(status)
      errors.add(:status, "is not a valid status")
    end
  end

  def sneaker_size_valid?
    self.sneaker_size % 0.5 == 0
  end
end
