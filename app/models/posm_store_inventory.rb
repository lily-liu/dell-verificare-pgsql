class PosmStoreInventory < ApplicationRecord
  mount_uploader :visibility, PosmVisibilityUploader
  validates :visibility, presence: true
  belongs_to :posm
  belongs_to :store
end
