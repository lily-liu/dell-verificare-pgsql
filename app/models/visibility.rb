class Visibility < ApplicationRecord
  enum status: [:front, :side, :banner, :signage]
  mount_uploader :visibility, PosmVisibilityUploader
  validates :visibility, presence: true
end
