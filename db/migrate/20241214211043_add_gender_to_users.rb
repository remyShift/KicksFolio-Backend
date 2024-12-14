class AddGenderToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :gender, :string
  end
end
