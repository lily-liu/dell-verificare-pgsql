class CreateConflictedInventories < ActiveRecord::Migration[5.0]
  def change
    create_table :conflicted_inventories do |t|
      t.string :service_tag, uniqueness: true, null: false
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :store, index: true, foreign_key: true
      t.integer :cause, default: 0

      t.datetime :deleted_at, null: true
      t.timestamps
    end
    add_index :conflicted_inventories, :service_tag, unique: true
  end
end
