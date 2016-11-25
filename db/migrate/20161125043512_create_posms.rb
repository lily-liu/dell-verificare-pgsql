class CreatePosms < ActiveRecord::Migration[5.0]
  def change
    create_table :posms do |t|
      t.string :name
      t.integer :quantity

      t.datetime :deleted_at, null: true
      t.timestamps
    end
  end
end
