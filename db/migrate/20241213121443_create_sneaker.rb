class CreateSneaker < ActiveRecord::Migration[8.0]
  def change
    create_table :sneakers do |t|
      t.string :brand
      t.string :model
      t.float :size
      t.date :purchase_date
      t.float :purchase_price
      t.integer :condition
      t.float :estimated_value
      t.timestamps
    end
  end
end
