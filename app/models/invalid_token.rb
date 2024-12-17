class InvalidToken < ApplicationRecord
  validates :token, presence: true
  validates :exp, presence: true

  scope :valid, -> { where('exp > ?', Time.now) }
end