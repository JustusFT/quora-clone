class QuestionVote < ActiveRecord::Base
  validates :question_id, presence: true
  validates :user_id, presence: true
  belongs_to :user
  belongs_to :questions

  # def one_vote_per_user
  #   unless QuestionVote.user
  #     errors.add(:user_id, "already voted")
  #     return false
  #   end
  # end
end
