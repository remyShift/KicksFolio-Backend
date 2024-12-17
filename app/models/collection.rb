class Collection < ApplicationRecord
  belongs_to :user
  has_many :sneakers, dependent: :destroy

  validates :name, presence: true
  validates :user_id, uniqueness: true
end
