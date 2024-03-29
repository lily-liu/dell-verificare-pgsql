class CreateInventories < ActiveRecord::Migration[5.0]
  def change
    create_table :inventories do |t|
      t.string :service_tag, uniqueness: true, null: false
      t.integer :status, default: 0
      t.belongs_to :sellin, index: true, foreign_key: true
      t.belongs_to :store, index: true, foreign_key: true
      t.integer :added_by, null:true
      t.belongs_to :user, index: true, foreign_key: true
      t.string :csv_ref, null: true
      t.datetime :transaction_date, null: true

      t.datetime :deleted_at, null: true
      t.timestamps
    end
    # unique index
    add_index :inventories, :service_tag, unique: true
    add_foreign_key :inventories, :users, column: :added_by
  end
end
