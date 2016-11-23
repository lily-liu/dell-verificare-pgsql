class Inventory < ApplicationRecord
  enum status: [:free, :sold]
  belongs_to :user
  has_one :sellout
  belongs_to :sellin
end
