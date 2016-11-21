class CreateProductKnowledges < ActiveRecord::Migration[5.0]
  def change
    create_table :product_knowledges do |t|
      t.string :name, null: false
      t.text :text, null: true
      t.string :file_name, null: false

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
