class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"

  after_initialize :set_default_status, if: :new_record?

  def accept
    self.status = "accepted"
  end

  def decline
    self.status = "declined"
  end

  def block
    self.status = "blocked"
  end

  private

  def set_default_status
    self.status = "pending"
  end
end
