class User < ApplicationRecord
  has_secure_password

  # enum values
  enum level: [:admin, :dashboard, :promoter, :merchandiser, :area_manager, :sales_representative]
  enum gender: [:male, :female, :other]
end
