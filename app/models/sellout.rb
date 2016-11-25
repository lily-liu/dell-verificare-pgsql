class Sellout < ApplicationRecord
  mount_uploader :proof, PhotoUploader
  belongs_to :user
  belongs_to :inventory
  belongs_to :store
end
