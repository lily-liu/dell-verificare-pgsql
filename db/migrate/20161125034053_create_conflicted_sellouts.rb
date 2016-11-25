class CreateConflictedSellouts < ActiveRecord::Migration[5.0]
  def change
    create_table :conflicted_sellouts do |t|
      t.belongs_to :inventory, index: true, foreign_key: true
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :store, index: true, foreign_key: true

      t.timestamps
    end
  end
end
