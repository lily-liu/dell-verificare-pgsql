class SellKit < ApplicationRecord
  enum category: [:other, :laptop, :desktop, :monitor, :program_info]
  enum family: [:other, :inspiron_3000, :inspiron_5000, :inspiron_7000, :vostro, :xps_12, :xps_13, :xps_15, :inspiron_desktop, :inspiron_aio, :monitor, :promotion]
  mount_uploader :file_name, FileNameUploader
  validates :file_name, presence: true
end
