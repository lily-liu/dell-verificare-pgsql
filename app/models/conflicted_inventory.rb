class ConflictedInventory < ApplicationRecord
  enum cause: [:no_sellin, :inventory_already_added]
end
