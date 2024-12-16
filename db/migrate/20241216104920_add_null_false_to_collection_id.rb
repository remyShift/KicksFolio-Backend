class AddNullFalseToCollectionId < ActiveRecord::Migration[8.0]
  def change
    change_column_null :sneakers, :collection_id, false
  end
end
