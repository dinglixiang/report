class CreatePurchases < ActiveRecord::Migration[5.0]
  def change
    create_table :purchases do |t|
      t.string :name
      t.string :size
      t.string :unit
      t.string :company
      t.datetime :purchase_date
      t.integer :purchase_volume
      t.string :upstream_client
    end

    add_index :purchases, :name
    add_index :purchases, :size
    add_index :purchases, :unit
    add_index :purchases, :company
    add_index :purchases, :purchase_date
    add_index :purchases, :upstream_client
  end
end
