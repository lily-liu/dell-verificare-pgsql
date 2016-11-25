class CreateConflictedInventories < ActiveRecord::Migration[5.0]
  def change
    create_table :conflicted_inventories do |t|
      t.belongs_to :sellin, index: true, foreign_key: true
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :store, index: true, foreign_key: true

      t.datetime :deleted_at, null: true
      t.timestamps
    end
  end
end
