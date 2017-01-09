class CreateSellins < ActiveRecord::Migration[5.0]
  def change
    create_table :sellins do |t|
      t.string :service_tag, uniqueness: true, null: false
      t.integer :quarter_year, null: false
      t.integer :quarter, null: false
      t.integer :quarter_week, null: false
      t.integer :item_type, null: false
      t.string :part_number, null: true
      t.string :product_type, null: true
      t.string :product_name, null: true
      t.integer :source_store, null: false
      t.integer :target_store, null: false
      t.string :csv_ref, null: true
      t.datetime :transaction_date, null: false, default: Time.now


      t.datetime :deleted_at, null: true
      t.timestamps
    end
    # nonstandard foreign key
    add_foreign_key :sellins, :stores, column: :source_store
    add_foreign_key :sellins, :stores, column: :target_store
    # unique index
    add_index :sellins, :service_tag, unique: true
  end
end
