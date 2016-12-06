class ConflictedSellout < ApplicationRecord
  enum cause: [:no_sellin, :sellout_already_added, :no_inventory_inputted]
  belongs_to :user
  belongs_to :store
end
