class Visibility < ApplicationRecord
  belongs_to :store
  belongs_to :user
  enum category: [:other, :dell_concept_store, :daily_visibility, :store_with_problems, :new_branding, :retail_feedback, :mall_branding, :roadshow, :dell_corner, :dell_signage, :non_mft]
  mount_uploader :visibility, PosmVisibilityUploader
  validates :visibility, presence: true
  validates :user, :store, presence: true
end
