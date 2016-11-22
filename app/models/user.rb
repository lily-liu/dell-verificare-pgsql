class User < ApplicationRecord
  has_secure_password

  # enum values
  enum level: [:admin, :dashboard, :promoter, :merchandiser, :area_manager, :sales_representative]
  enum gender: [:male, :female, :other]

  # knock auth override
  def from_token_request(request)
    # Returns a valid user, `nil` or raise `Knock.not_found_exception_class_name`
    if request.params[:auth].present? && request.params[:auth][:username].present?
      user_name = request.params[:auth][:username]
      find_by username: user_name
    else
      raise Knock.not_found_exception_class_name
    end
  end

  def to_token_payload
    # Returns a valid user, `nil` or raise
    return {user_id: self.id}
  end

end
