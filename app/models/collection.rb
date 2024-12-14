class Collection < ApplicationRecord
  belongs_to :user
  belongs_to :sneaker

  validates :name, presence: true
  validates :user_id, uniqueness: true
end
