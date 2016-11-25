class Issue < ApplicationRecord
  enum impact: [:no_impact, :positive, :negative, :other]
  belongs_to :user
end
