class CreateStores < ActiveRecord::Migration[5.0]
  def change
    create_table :stores do |t|
      t.string :store_uid, uniqueness: true, null: false
      t.belongs_to :city, index: true, foreign_key: true
      t.string :name, null: false
      t.string :address, null: false
      t.string :phone
      t.string :email

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
