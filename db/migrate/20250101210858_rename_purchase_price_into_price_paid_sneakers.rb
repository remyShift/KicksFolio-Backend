class RenamePurchasePriceIntoPricePaidSneakers < ActiveRecord::Migration[8.0]
  def change
    rename_column :sneakers, :purchase_price, :price_paid
  end
end

