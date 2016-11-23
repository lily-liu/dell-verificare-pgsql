class Store < ApplicationRecord
  enum level: [:tier_1_dealer, :tier_2_dealer, :tier_3_dealer]
  has_many :absences, dependent: :nullify
  has_many :users, through: :absences, dependent: :nullify
  belongs_to :city
end
