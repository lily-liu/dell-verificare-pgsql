class User < ApplicationRecord
  has_secure_password
  acts_as_paranoid

  # enum values
  enum level: [:admin, :dashboard, :promoter, :merchandiser, :area_manager, :sales_representative]
  enum gender: [:male, :female, :other]
end
