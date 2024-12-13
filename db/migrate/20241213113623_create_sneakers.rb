class CreateSneakers < ActiveRecord::Migration[8.0]
  def change
    create_table :sneakers do |t|
      t.references :collection, null: false, foreign_key: true
      t.string :brand
      t.string :model
      t.float :size
      t.string :colorway
      t.date :purchase_date
      t.float :purchase_price
      t.float :estimated_value
      t.string :image_url

      t.timestamps
    end
  end
end
