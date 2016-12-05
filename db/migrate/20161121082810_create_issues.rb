class CreateIssues < ActiveRecord::Migration[5.0]
  def change
    create_table :issues do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :store, index: true, foreign_key: true
      t.string :program_name, null: false
      t.string :brand_name, null: false
      t.string :store_name, null: false
      t.integer :impact, default: 0
      t.datetime :campaign_start, null: false
      t.datetime :campaign_end, null: true
      t.string :remark, null: true
      t.string :photo_name, null: false

      t.datetime :deleted_at, null: true
      t.timestamps
    end
  end
end
