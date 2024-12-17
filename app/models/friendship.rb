class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"

  def accept
    self.status = "accepted"
  end

  def decline
    self.status = "declined"
  end

  def block
    self.status = "blocked"
  end
end
