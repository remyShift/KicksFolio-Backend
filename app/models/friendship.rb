class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"

  after_initialize :set_default_status, if: :new_record?

  def accept
    transaction do
      update(status: "accepted")
      Friendship.find_or_create_by(user_id: friend_id, friend_id: user_id)
        .update(status: "accepted")
    end
    save
  end

  def decline
    transaction do
      update(status: "declined")
      Friendship.find_or_create_by(user_id: friend_id, friend_id: user_id)
        .update(status: "declined")
    end
    save
  end

  def block
    transaction do
      update(status: "blocked")
      Friendship.find_or_create_by(user_id: friend_id, friend_id: user_id)
        .update(status: "blocked")
    end
    save
  end

  private

  def set_default_status
    self.status = "pending"
    save
  end
end
