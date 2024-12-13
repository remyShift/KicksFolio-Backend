class RemoveDescriptionFromCollections < ActiveRecord::Migration[8.0]
  def change
    remove_column :collections, :description
  end
end
