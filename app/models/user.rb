class User < ApplicationRecord
  has_many :friends, through: :friendships
  has_many :sneakers, through: :collections
end
