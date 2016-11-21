class Absence < ApplicationRecord
  enum absence_type: [:other, :in, :out, :sick]
end
