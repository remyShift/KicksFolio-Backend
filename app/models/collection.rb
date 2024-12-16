class Collection < ApplicationRecord
  belongs_to :user
  has_many :sneakers

  validates :name, presence: true
  validates :user_id, uniqueness: true
end
