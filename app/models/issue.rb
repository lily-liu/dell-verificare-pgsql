class Issue < ApplicationRecord
  mount_uploader :photo_name, IssueUploader
  validates :photo_name, presence: true

  belongs_to :user
  belongs_to :store
end
