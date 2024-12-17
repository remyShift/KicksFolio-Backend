class AddDescriptionToSneakers < ActiveRecord::Migration[8.0]
  def change
    add_column :sneakers, :description, :text
  end
end

