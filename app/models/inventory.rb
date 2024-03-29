class Inventory < ApplicationRecord
  enum status: [:free, :sold, :sold_to_other_store]
  belongs_to :user
  belongs_to :added_by, class_name: "User", foreign_key: "added_by"
  belongs_to :store
  belongs_to :sellin
  has_one :sellout

  validates :service_tag, :user, :store, :sellin, :status, presence: true
end
