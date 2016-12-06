class ConflictedInventory < ApplicationRecord
  enum cause: [:no_sellin, :inventory_already_added]
  belongs_to :user
  belongs_to :store

end
