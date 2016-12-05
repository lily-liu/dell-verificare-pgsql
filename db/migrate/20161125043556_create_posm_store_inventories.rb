class CreatePosmStoreInventories < ActiveRecord::Migration[5.0]
  def change
    create_table :posm_store_inventories do |t|
      t.belongs_to :posm, index: true, foreign_key: true
      t.belongs_to :store, index: true, foreign_key: true
      t.belongs_to :user, index: true, foreign_key: true
      t.integer :quantity
      t.string :visibility

      t.datetime :deleted_at, null: true
      t.timestamps
    end
  end
end
