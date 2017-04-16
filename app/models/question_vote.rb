class QuestionVote < ActiveRecord::Base
  validates :question_id, presence: true
  validates :user_id, presence: true
  validates :vote_type, presence: true
  belongs_to :user
  belongs_to :questions
end
