class RemoveDefaultValueForStatusFriendShips < ActiveRecord::Migration[8.0]
  def change
    change_column_default :friendships, :status, nil
  end
end

