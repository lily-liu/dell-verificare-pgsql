class Absence < ApplicationRecord
  enum absence_type: [:other, :in, :out, :sick]
  belongs_to :user
  belongs_to :store

  validates :store, :user, presence: true
  validates :latitude, :longitude, presence: true, numericality: true
end
