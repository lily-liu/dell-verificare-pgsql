class CreatePosms < ActiveRecord::Migration[5.0]
  def change
    create_table :posms do |t|
      t.string :name, null: false
      t.integer :category, default: 0
      t.integer :quantity, null: false

      t.datetime :deleted_at, null: true
      t.timestamps
    end
  end
end
