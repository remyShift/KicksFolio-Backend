class AllNullFalseForAllTable < ActiveRecord::Migration[8.0]
  def change
    change_column_null :users, :first_name, false
    change_column_null :users, :last_name, false
    change_column_null :users, :pseudo, false
    change_column_null :users, :sneaker_size, false

    change_column_null :sneakers, :brand, false
    change_column_null :sneakers, :model, false
    change_column_null :sneakers, :size, false
    change_column_null :sneakers, :condition, false

    change_column_null :collections, :name, false
  end
end
