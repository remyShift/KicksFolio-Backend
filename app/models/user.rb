class User < ApplicationRecord
  GENDER = { male: "male", female: "female", other: "other" }

  has_one :collection, dependent: :destroy
  has_many :sneakers, through: :collection, dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships, dependent: :destroy

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
  validates :sneaker_size, presence: true
  validates :gender, presence: true, inclusion: { in: GENDER.values }

  validate :sneaker_size_within_range

  before_save :downcase_email
  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  private

  def downcase_email
    self.email = email.downcase
  end

  def sneaker_size_within_range
    return if sneaker_size.nil?

    if sneaker_size % 0.5 != 0
      errors.add(:sneaker_size, "must be in increments of 0.5")
    end

    case gender
    when "male"
      unless (4..15).include?(sneaker_size)
        errors.add(:sneaker_size, "must be between 4 and 15 for men")
      end
    when "female"
      unless (5..12).include?(sneaker_size)
        errors.add(:sneaker_size, "must be between 5 et 12 for women")
      end
    when "other"
      unless (4..15).include?(sneaker_size)
        errors.add(:sneaker_size, "must be between 4 and 15 for no gender")
      end
    end
  end
end
