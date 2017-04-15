class User < ActiveRecord::Base
  validates :email, uniqueness: true
  validate :password_validator, :email_validator
  before_create :password_validator, :email_validator
  has_secure_password

  def password_validator
    unless self.password.length < 8
      errors.add(:password, "is too short")
    end
  end

  def email_validator
    unless self.email =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      errors.add(:email, "is not valid")
    end
  end
end
