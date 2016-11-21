class CreateStores < ActiveRecord::Migration[5.0]
  def change
    create_table :stores do |t|
      t.string :store_uid, uniqueness: true
      t.belongs_to :city, index: true, foreign_key: true
      t.string :name
      t.string :address
      t.string :phone
      t.string :email

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
