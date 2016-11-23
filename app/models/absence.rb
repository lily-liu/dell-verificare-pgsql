class Absence < ApplicationRecord
  enum absence_type: [:other, :in, :out, :sick]
  belongs_to :user
  belongs_to :store
end
