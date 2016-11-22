class CreateCities < ActiveRecord::Migration[5.0]
  def change
    create_table :cities do |t|
      t.string :name, null: false
      t.belongs_to :region, index: true, foreign_key: true

      t.datetime :deleted_at, null: true
      t.timestamps
    end
  end
end
