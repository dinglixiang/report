class CreateReports < ActiveRecord::Migration[5.0]
  def change
    create_table :reports do |t|
      t.string :name
      t.string :size
      t.string :unit
      t.string :company
      t.datetime :sell_date
      t.string :target_company
      t.integer :sell_volume
    end

    add_index :reports, :name
    add_index :reports, :size
    add_index :reports, :unit
    add_index :reports, :company
    add_index :reports, :sell_date
    add_index :reports, :target_company
  end
end
