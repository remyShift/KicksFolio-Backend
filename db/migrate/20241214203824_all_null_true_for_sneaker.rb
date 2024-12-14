class AllNullTrueForSneaker < ActiveRecord::Migration[8.0]
  def change
    change_column_null :sneakers, :purchase_date, true
    change_column_null :sneakers, :purchase_price, true
    change_column_null :sneakers, :estimated_value, true
  end
end
