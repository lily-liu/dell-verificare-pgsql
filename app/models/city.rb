class City < ApplicationRecord
  belongs_to :region
  has_many :stores, dependent: :nullify

  validates :name, :region, presence: true
end
