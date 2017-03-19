class CreateReports < ActiveRecord::Migration[5.0]
  def change
    create_table :reports do |t|
      t.integer :user_id
      t.string :name
      t.string :size
      t.string :unit
      t.string :company
      t.datetime :sell_date
      t.string :target_company
      t.integer :sell_volume
    end

    add_index :reports, [:user_id, :name]
    add_index :reports, [:user_id, :size]
    add_index :reports, [:user_id, :unit]
    add_index :reports, [:user_id, :company]
    add_index :reports, [:user_id, :sell_date]
    add_index :reports, [:user_id, :target_company]
  end
end
