class AddSneakerSizeToUser < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :sneaker_size, :float
  end
end
