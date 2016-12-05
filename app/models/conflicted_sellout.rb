class ConflictedSellout < ApplicationRecord
  enum cause: [:no_sellin, :sellout_already_added, :no_inventory_inputted]
end
