class User < ApplicationRecord
  has_one_attached :profile_picture
  has_one :collection, dependent: :destroy
  has_many :sneakers, through: :collection, dependent: :destroy

  has_many :friendships, dependent: :destroy
  has_many :received_friendships, class_name: "Friendship", foreign_key: :friend_id
  has_many :friends,
            -> { where(friendships: { status: "accepted" }) },
            through: :friendships,
            source: :friend
  has_many :pending_friends,
            -> { where(friendships: { status: "pending" }) },
            through: :friendships,
            source: :friend
  has_many :blocked_friends,
            -> { where(friendships: { status: "blocked" }) },
            through: :friendships,
            source: :friend
  has_secure_password

  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password,
            presence: true,
            length: { minimum: 8 },
            format: { with: /\A(?=.*[A-Z])(?=.*\d).+\z/ },
            if: -> { new_record? || !password.nil? }
  validates :username, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :sneaker_size, presence: true, numericality: { greater_than: 7, less_than: 16 }

  validate :sneaker_size_valid?
  before_save :downcase_email

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  def friends_list
    friends.map { |friend| { id: friend.id, username: friend.username, first_name: friend.first_name, last_name: friend.last_name } }
  end

  def pending_friends_list
    pending_friends.map { |friend| { id: friend.id, username: friend.username, first_name: friend.first_name, last_name: friend.last_name } }
  end

  def blocked_friends_list
    blocked_friends.map { |friend| { id: friend.id, username: friend.username, first_name: friend.first_name, last_name: friend.last_name } }
  end

  def sneaker_size_valid?
    return if sneaker_size.nil?
    unless (sneaker_size % 0.5).zero?
      errors.add(:sneaker_size, "doit être par incréments de 0.5")
    end
  end

  private

  def downcase_email
    self.email = email.downcase
  end

  def profile_picture_attached?
    profile_picture.attached?
  end
end
