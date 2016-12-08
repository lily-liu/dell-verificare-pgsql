class SellKit < ApplicationRecord
  enum category: [:others, :laptops, :desktops, :monitors, :program_infos]
  enum family: [:other_family, :inspiron_3000, :inspiron_5000, :inspiron_7000, :vostro, :xps_12, :xps_13, :xps_15, :inspiron_desktop, :inspiron_aio, :monitor_item, :promotion_item]
  mount_uploader :file_name, FileNameUploader
  validates :file_name, presence: true
  validates :name, :description, presence: true
end
