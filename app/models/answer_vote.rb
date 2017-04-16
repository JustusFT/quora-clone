class AnswerVote < ActiveRecord::Base
  validates :answer_id, presence: true
  validates :user_id, presence: true
  belongs_to :user
  belongs_to :answer
end
