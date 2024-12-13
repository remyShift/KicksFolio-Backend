class RemoveColorwayFromSneakers < ActiveRecord::Migration[8.0]
  def change
    remove_column :sneakers, :colorway
  end
end
