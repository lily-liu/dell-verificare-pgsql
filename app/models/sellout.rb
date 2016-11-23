class Sellout < ApplicationRecord
  belongs_to :user
  belongs_to :inventory
  belongs_to :store
end
