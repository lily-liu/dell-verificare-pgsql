class Sellout < ApplicationRecord
  mount_uploader :proof, PhotoUploader
  validates :proof, presence: true
  belongs_to :user
  belongs_to :added_by, class_name: "User", foreign_key: "added_by"
  belongs_to :inventory
  belongs_to :store

  validates :service_tag, :quarter, :quarter_week, :quarter_year, :store, :user, :inventory, presence: true
end
