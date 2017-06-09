class CreateSkuFilters < ActiveRecord::Migration[5.0]
  def change
    create_table :sku_filters do |t|
      t.string :sku, null: true
      t.string :price_category, null: true
      t.datetime :deleted_at, null: true
      t.timestamps
    end
  end
end
