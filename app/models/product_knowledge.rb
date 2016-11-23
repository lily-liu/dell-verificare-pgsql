class ProductKnowledge < ApplicationRecord
  mount_uploader :file_name, FileNameUploader
  validates :file_name, presence: true
end
