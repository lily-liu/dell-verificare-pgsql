class PosmStoreInventory < ApplicationRecord
  belongs_to :posm
  belongs_to :store
end
