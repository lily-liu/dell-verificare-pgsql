class CreateConflictedSellouts < ActiveRecord::Migration[5.0]
  def change
    create_table :conflicted_sellouts do |t|
      t.string :service_tag, uniqueness: true, null: false
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :store, index: true, foreign_key: true
      t.integer :cause, default: 0
      t.boolean :solved, default: false

      t.datetime :deleted_at, null: true
      t.timestamps
    end
  end
end
