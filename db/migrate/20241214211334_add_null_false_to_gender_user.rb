class AddNullFalseToGenderUser < ActiveRecord::Migration[8.0]
  def change
    change_column_null :users, :gender, false
  end
end
