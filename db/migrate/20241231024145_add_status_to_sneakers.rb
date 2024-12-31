class AddStatusToSneakers < ActiveRecord::Migration[8.0]
  def change
    add_column :sneakers, :status, :string, null: false, default: 'rocking'
  end
end
