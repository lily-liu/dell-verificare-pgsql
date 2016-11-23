class CreateSellouts < ActiveRecord::Migration[5.0]
  def change
    create_table :sellouts do |t|
      t.string :service_tag, null: false, uniqueness: true
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :inventory, index: true, foreign_key: true
      t.belongs_to :store, index: true, foreign_key: true
      t.integer :quarter_year, null: false
      t.integer :quarter, null: false
      t.integer :quarter_week, null: false
      t.float :price_idr, null: true
      t.float :price_usd, null: true

      t.datetime :deleted_at, null: true
      t.timestamps
    end
    # unique index
    add_index :sellouts, :service_tag, unique: true
  end
end
