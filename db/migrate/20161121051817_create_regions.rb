class CreateRegions < ActiveRecord::Migration[5.0]
  def change
    create_table :regions do |t|
      t.string :name, null: false
      t.integer :position, null: false

      t.datetime :deleted_at, null: true
      t.timestamps
    end
  end
end
