class Store < ApplicationRecord
  enum level: [:tier_1_dealer, :tier_2_dealer, :tier_3_dealer]
  enum store_category: [:non_mft, :dell_corner, :dell_signage, :dell_exclusive_store]
  has_many :absences, dependent: :nullify
  has_many :sellouts, dependent: :nullify
  has_many :inventories, dependent: :nullify
  has_many :issues, dependent: :nullify
  has_many :conflicted_inventories, dependent: :nullify
  has_many :conflicted_sellouts, dependent: :nullify
  has_many :visibilities, dependent: :nullify
  has_many :users, through: :absences, dependent: :nullify
  has_many :posms, through: :posm_store_inventories, dependent: :nullify
  belongs_to :city

  validates :store_uid, :city, :name, :address, presence: true
end
