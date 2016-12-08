class ConflictedSellout < ApplicationRecord
  enum cause: [:no_sellin, :sellout_already_added, :no_inventory_inputted]
  belongs_to :user
  belongs_to :store

  validates :service_tag, :user, :store, :cause, :solved, presence: true
end
