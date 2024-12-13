class AddStatusToFriendship < ActiveRecord::Migration[8.0]
  def change
    add_column :friendships, :status, :string, default: "pending"
  end
end
