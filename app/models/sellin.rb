class Sellin < ApplicationRecord
  enum item_type: [:desktop_computer, :laptop_computer]
  has_one :inventory

  validates :service_tag, :quarter, :quarter_week, :quarter_year, :source_store, :target_store, presence: true
end
