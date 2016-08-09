class CreateStocks < ActiveRecord::Migration[5.0]
  def change
    create_table :stocks do |t|
      t.string :name
      t.string :size
      t.string :unit
      t.string :company
      t.integer :stock_volume
    end

    add_index :stocks, :name
  end
end
