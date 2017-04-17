class User < ActiveRecord::Base
  validates :email, uniqueness: true, presence: true
  validates :full_name, presence: true
  validate :password_validator, :email_validator
  before_create :password_validator, :email_validator
  has_secure_password
  has_many :questions
  has_many :answers
  has_many :question_votes
  has_many :answer_votes

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

  def vote(vote_type, model, id)
    model_class = "#{model.titleize}Vote".constantize
    model_key = "#{model}_id"
    #update vote in case already previously voted
    unless self.send("#{model}_votes").find_by("#{model_key} = ?", id).nil?
      vote = model_class.find_by("#{model_key} = ?", id)
      vote.vote_type = vote_type
      return vote.save
    else
      vote = model_class.new
      vote.send("#{model}_id=", id)
      vote.user_id = self.id
      vote.vote_type = vote_type
      return vote.save
    end
  end

  def remove_vote(model, id)
    model_key = "#{model}_id"
    vote = self.send("#{model}_votes").find_by("#{model_key} = ?", id)
    return vote.destroy
  end
end
