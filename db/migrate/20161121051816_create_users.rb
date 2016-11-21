class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :username, uniqueness: true, null: false
      t.string :password, null: false
      t.integer :level, default: 0
      t.string :name, default: ""
      t.string :email, uniqueness: true, null: false
      t.string :phone, default: ""
      t.integer :gender, default: 3

      t.datetime :deleted_at
      t.timestamps
    end
    # unique indexes
    add_index :users, :username, unique: true
    add_index :users, :email, unique: true
  end
end
