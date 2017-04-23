class Answer < ActiveRecord::Base
  include Votable
  validates :answer, presence: true
  validates :user_id, presence: true
  validates :question_id, presence: true
  validate :one_answer_per_question
  before_create :one_answer_per_question
  belongs_to :question
  belongs_to :user
  has_many :comments

  def one_answer_per_question
    self.question.answers.each do |x|
      if x.user_id == self.user_id
        errors.add(:answer, "already answerd this question")
        return false
      end
    end
  end
end
