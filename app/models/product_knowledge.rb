class ProductKnowledge < ApplicationRecord
  mount_uploader :file_name, FileNameUploader
  validates :name, presence: true
end
