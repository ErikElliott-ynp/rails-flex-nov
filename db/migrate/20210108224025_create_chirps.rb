class CreateChirps < ActiveRecord::Migration[5.2]
  def change
    create_table :chirps do |t|
      t.string :body, null: false
      t.integer :user_id, null: false

      t.timestamps
    end
    add_index :chirps, :user_id
  end
end
