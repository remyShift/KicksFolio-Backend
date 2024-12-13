class DeleteUser < ActiveRecord::Migration[8.0]
  def change
    drop_table :users, force: :cascade
  end
end
