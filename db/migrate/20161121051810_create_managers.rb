class CreateManagers < ActiveRecord::Migration[5.0]
  def change
    create_table :managers do |t|
      t.string :name, null: false
      t.integer :parent_id, null: true

      t.datetime :deleted_at, null: true
      t.timestamps
    end
    # nonstandard foreign key
    add_foreign_key :managers, :managers, column: :parent_id
  end
end
