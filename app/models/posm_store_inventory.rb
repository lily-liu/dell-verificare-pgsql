class PosmStoreInventory < ApplicationRecord
  mount_uploader :visibility, PosmVisibilityUploader
  validates :visibility, presence: true
  belongs_to :posm
  belongs_to :store

  validates :posm, :store, :user, :quantity, presence: true
  validates :quantity, numericality: {only_integer: true}
end
