class User < ActiveRecord::Base
  validates :email, uniqueness: true, presence: true
  validates :full_name, presence: true
  validate :password_validator, :email_validator
  before_create :password_validator, :email_validator
  has_secure_password
  has_many :questions
  has_many :answers
  has_many :comments
  has_many :question_votes
  has_many :answer_votes
  # has_many :comment_votes

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
