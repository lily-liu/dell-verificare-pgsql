class User < ApplicationRecord
  has_secure_password

  # enum values
  enum level: [:admin, :dashboard, :area_manager, :promoter, :merchandiser, :sales_representative, :store_user]
  enum gender: [:male, :female, :other]
  has_many :absences, dependent: :nullify
  has_many :posm_store_inventories, dependent: :nullify
  has_many :stores, through: :absences, dependent: :nullify
  has_many :posm, through: :posm_store_inventories, dependent: :nullify
  has_many :sellouts, dependent: :nullify
  has_many :issues, dependent: :nullify
  has_many :visibilities, dependent: :nullify
  has_many :inventories, dependent: :nullify
  has_many :conflicted_inventories, dependent: :nullify
  has_many :conflicted_sellouts, dependent: :nullify
  belongs_to :manager

  validates :username, :name, :manager, :password_digest, presence: true

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

  # override jwt payload
  def to_token_payload
    # Returns a valid user, `nil` or raise
    return {created: Time.now.to_i, sub: self.id, username: self.username, name: self.name, email: self.email, level: self.level}
  end

end
