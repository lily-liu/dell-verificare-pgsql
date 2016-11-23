class Sellin < ApplicationRecord
  enum item_type: [:desktop_computer, :laptop_computer]
  has_one :inventory
end
