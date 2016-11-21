class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :username, uniqueness: true
      t.string :password
      t.integer :level, default: 0
      t.string :name, default: ""
      t.string :email, uniqueness: true
      t.string :phone, default: ""
      t.integer :gender, default: 3
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
