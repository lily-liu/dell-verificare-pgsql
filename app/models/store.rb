class Store < ApplicationRecord
  has_many :absences, dependent: :nullify
  has_many :users,trough :absences, dependent: :nullify
  belongs_to :city
end
