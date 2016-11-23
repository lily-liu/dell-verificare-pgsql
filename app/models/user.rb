class User < ApplicationRecord
  has_secure_password

  # enum values
  enum level: [:admin, :dashboard, :promoter, :merchandiser, :area_manager, :sales_representative]
  enum gender: [:male, :female, :other]
  has_many :absences, dependent: :nullify
  has_many :stores, trough :absences, dependent: :nullify
  has_many :sellouts, dependent: :nullify
  has_many :issues, dependent: :nullify
  has_many :inventories, dependent: :nullify
  belongs_to :manager

    # knock auth override
    # def self.from_token_request(request)
    #   # Returns a valid user, `nil` or raise `Knock.not_found_exception_class_name`
    #   if request.params[:auth].present? && request.params[:auth][:username].present?
    #     user_name = request.params[:auth][:username]
    #     find_by username: user_name
    #   else
    #     raise Knock.not_found_exception_class_name
    #   end
    # end

    # def self.from_token_payload(payload)
    #   # Returns a valid user, `nil` or raise
    #   self.find payload["sub"]
    # end

    # def to_token_payload
    #   # Returns a valid user, `nil` or raise
    #   return {user_id: self.id}
    # end

end
