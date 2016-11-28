class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :title, null: true
      t.string :content, null: false
      t.belongs_to :user, index: true, foreign_key: true
      t.integer :level, null: false
      t.integer :parent_id, null: true

      t.datetime :deleted_at, null: true
      t.timestamps
    end
    add_foreign_key :posts, :posts, column: :parent_id
  end
end
