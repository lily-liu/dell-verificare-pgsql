class CreateVisibilities < ActiveRecord::Migration[5.0]
  def change
    create_table :visibilities do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :store, index: true, foreign_key: true
      t.integer :category, default: 0
      t.string :visibility, null: false
      t.string :remark, null: true

      t.datetime :deleted_at, null: true
      t.timestamps
    end
  end
end
