class Absence < ApplicationRecord
  enum absence_type: [:other, :in, :out, :sick]
  belongs_to :user
  belongs_to :store

  validates :store, :user, presence: true
  validates :latitude, :longitude, presence: true, numericality: true
  validates :remark, allow_blank: true, allow_nil: true
end
