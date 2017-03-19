class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :username, limit: 20
      t.string :password_digest
      t.string :salt, limit: 30
    end

    add_index :users, :username
  end
end
