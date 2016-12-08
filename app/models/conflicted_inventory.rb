class ConflictedInventory < ApplicationRecord
  enum cause: [:no_sellin, :inventory_already_added]
  belongs_to :user
  belongs_to :store

  validates :service_tag, :user, :store, :cause, :solved, presence: true
end
