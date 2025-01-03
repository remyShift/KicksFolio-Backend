class Sneaker < ApplicationRecord
  belongs_to :collection
  has_many_attached :images

  STATUS = ['rocking', 'stocking', 'selling']

  validates :brand, presence: true
  validates :model, presence: true
  validates :size, presence: true, numericality: { greater_than: 7, less_than: 16 }
  validates :condition, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 10 }
  validates :status, presence: true, inclusion: { in: STATUS }
  validates :collection_id, presence: true
  validates :images, presence: true, content_type: ['image/jpeg', 'image/png']

  validate :sneaker_size_valid?

  private

  def sneaker_size_valid?
    return if size.nil?
    unless (size % 0.5).zero?
      errors.add(:size, "must be in increments of 0.5")
    end
  end
end
