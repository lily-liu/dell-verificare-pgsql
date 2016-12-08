class Issue < ApplicationRecord
  mount_uploader :photo_name, IssueUploader
  validates :photo_name, presence: true
  belongs_to :user
  belongs_to :store

  validates :user, :store, :brand_name, :campaign_end, :campaign_start, :program_name, :store_name, :impact, presence: true
end
