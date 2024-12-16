class RemoveSneakerIdForCollectionAndAddForeignKeyInSneaker < ActiveRecord::Migration[8.0]
  def change
    remove_column :collections, :sneaker_id
    add_reference :sneakers, :collection, foreign_key: true
  end
end
