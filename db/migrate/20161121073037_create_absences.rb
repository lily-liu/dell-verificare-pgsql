class CreateAbsences < ActiveRecord::Migration[5.0]
  def change
    create_table :absences do |t|
      t.string :absence_token, null: true
      t.integer :absence_type, default: 0
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :store, index: true, foreign_key: true
      t.float :latitude, default: 0
      t.float :longitude, default: 0
      t.string :remark, null: true

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
