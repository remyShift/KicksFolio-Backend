class RemoveAuthForUser2 < ActiveRecord::Migration[8.0]
  def change
    remove_column :users, :provider, :string
    remove_column :users, :uid, :string
    remove_column :users, :allow_password_change, :boolean
    remove_column :users, :tokens, :json
    remove_column :users, :unconfirmed_email, :string
    remove_column :users, :confirmation_sent_at, :datetime
    remove_column :users, :confirmed_at, :datetime
    remove_column :users, :confirmation_token, :string
  end
end

