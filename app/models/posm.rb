class Posm < ApplicationRecord
  has_many :posm_store_inventories, dependent: :nullify
end
