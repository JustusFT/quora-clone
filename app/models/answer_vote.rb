class AnswerVote < Vote
  validates :answer_id, presence: true
  belongs_to :answer
  belongs_to :user
end
