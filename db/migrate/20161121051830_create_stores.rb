class CreateStores < ActiveRecord::Migration[5.0]
  def change
    create_table :stores do |t|
      t.string :store_uid, uniqueness: true, null: false
      t.belongs_to :city, index: true, foreign_key: true
      t.string :name, null: false
      t.integer :level, default: 0
      t.string :address, null: false
      t.string :phone, null: true
      t.string :email, null: true
      t.string :store_building, null: false
      t.string :store_owner, null: false

      t.datetime :deleted_at, null: true
      t.timestamps
    end
    # unique index
    add_index :stores, :store_uid, unique: true
  end
end
