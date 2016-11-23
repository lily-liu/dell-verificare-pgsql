class Region < ApplicationRecord
  enum region_position: [:region_1, :region_2, :region_3, :region_4]
  has_many :cities, dependent: :nullify
end
