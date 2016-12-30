class CreateSellouts < ActiveRecord::Migration[5.0]
  def change
    # default_image = DefaultImageUploader.new
    # default_image.store!(File.open(Rails.root + "public/uploads/default.png"))

    create_table :sellouts do |t|
      t.string :service_tag, null: false, uniqueness: true
      t.belongs_to :user, index: true, foreign_key: true
      t.integer :added_by, null: true
      t.belongs_to :inventory, index: true, foreign_key: true
      t.belongs_to :store, index: true, foreign_key: true
      t.integer :quarter_year, null: false
      t.integer :quarter, null: false
      t.integer :quarter_week, null: false
      t.float :price_idr, null: true
      t.float :price_usd, null: true
      t.string :proof, null: false, default: "default.png"
      t.string :csv_ref, null: true
      t.datetime :sales_date, null: false, default: Time.now


      t.datetime :deleted_at, null: true
      t.timestamps
    end
    # unique index
    add_index :sellouts, :service_tag, unique: true
    add_foreign_key :sellouts, :users, column: :added_by
  end
end
