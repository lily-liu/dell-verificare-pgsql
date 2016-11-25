class Inventory < ApplicationRecord
  enum status: [:free, :sold]
  belongs_to :user
  belongs_to :store
  belongs_to :sellin
  has_one :sellout
end
