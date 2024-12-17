class CreateInvalidtokens < ActiveRecord::Migration[8.0]
  def change
    create_table :invalid_tokens do |t|
      t.string :token
      t.datetime :exp
      t.timestamps
    end
  end
end
