class CreateUser < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.timestamps
    end
  end
end
