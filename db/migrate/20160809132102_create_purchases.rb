class CreatePurchases < ActiveRecord::Migration[5.0]
  def change
    create_table :purchases do |t|
      t.integer :user_id
      t.string :name
      t.string :size
      t.string :unit
      t.string :company
      t.datetime :purchase_date
      t.integer :purchase_volume
      t.string :upstream_client
    end

    add_index :purchases, [:user_id, :name]
    add_index :purchases, [:user_id, :size]
    add_index :purchases, [:user_id, :unit]
    add_index :purchases, [:user_id, :company]
    add_index :purchases, [:user_id, :purchase_date]
    add_index :purchases, [:user_id, :upstream_client]
  end
end
