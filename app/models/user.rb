class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :friends, through: :friendships
  has_many :sneakers, through: :collections
  has_one :collection

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 8 }, format: { with: /\A(?=.*[A-Z])(?=.*\d).+\z/ }
  validates :pseudo, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :sneaker_size, presence: true
  validates :gender, presence: true
end
