class Manager < ApplicationRecord
  has_many :users, dependent: :nullify
  has_many :area_manager, class_name: "Manager", foreign_key: "parent_id"
  belongs_to :channel_area_manager, class_name: "Manager"
end
