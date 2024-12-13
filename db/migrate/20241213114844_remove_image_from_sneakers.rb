class RemoveImageFromSneakers < ActiveRecord::Migration[8.0]
  def change
    remove_column :sneakers, :image_url
  end
end
