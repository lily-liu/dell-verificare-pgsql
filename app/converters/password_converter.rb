class PasswordConverter
  def self.convert(value)
    BCrypt::Password.create(value)
  end
end