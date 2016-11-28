class Manager < ApplicationRecord
  enum level: [:channel_area_manager, :area_manager]
  has_many :users, dependent: :nullify
  has_many :area_managers, class_name: "Manager", foreign_key: "parent_id"
  belongs_to :channel_area_manager, class_name: "Manager", foreign_key: "parent_id"
end
