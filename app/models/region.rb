class Region < ApplicationRecord
  has_many :cities, dependent: :nullify
end
