class RenamePseudoToUsernameForUser < ActiveRecord::Migration[8.0]
  def change
    rename_column :users, :pseudo, :username
  end
end
