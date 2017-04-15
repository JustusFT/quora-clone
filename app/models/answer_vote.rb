class AnswerVote < ActiveRecord::Base
  validates :answer_id, presence: true
  validates :user_id, presence: true
end
