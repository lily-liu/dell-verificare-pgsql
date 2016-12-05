class Region < ApplicationRecord
  enum position: [:region1, :region2, :region3, :region4]
  has_many :cities, dependent: :nullify
end
