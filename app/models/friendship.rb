class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"

  after_initialize :set_default_status, if: :new_record?

  def accept
    self.status = "accepted"
    save
  end

  def decline
    self.status = "declined"
    save
  end

  def block
    self.status = "blocked"
    save
  end

  private

  def set_default_status
    self.status = "pending"
    save
  end
end
