class Sneaker < ApplicationRecord
  belongs_to :collection
  has_many_attached :images

  STATUS = ['rocking', 'stocking', 'selling', 'other']

  validates :brand, :model, :size, :condition, :status, presence: true
  validates :collection_id, presence: true
  validates :images, presence: true

  validate :status_inclusion

  def status_inclusion
    unless STATUS.include?(status)
      errors.add(:status, "is not a valid status")
    end
  end
end
