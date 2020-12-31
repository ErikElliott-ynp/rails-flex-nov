class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.integer :age
      t.string :email, null: false
      t.string :username, null: false
      t.boolean :is_cool?, default: true

      t.timestamps
    end
    add_index :users, :username, unique: true
  end
end
