class CreateSellKits < ActiveRecord::Migration[5.0]
  def change
    create_table :sell_kits do |t|
      t.string :name, null: false
      t.text :description, null: true
      t.string :file_name, null: false
      t.integer :category, default: 0
      t.integer :family, null: true

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
