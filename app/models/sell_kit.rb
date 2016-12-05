class SellKit < ApplicationRecord
  enum category: [:laptop, :desktop, :monitor, :promotion]
  enum family: [:inspiron, :vostro, :xps, :aio, :pc, :monitor1, :monitor2]
  mount_uploader :file_name, FileNameUploader
  validates :file_name, presence: true
end
