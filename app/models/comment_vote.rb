class CommentVote < Vote
  validates :comment_id, presence: true
  belongs_to :comment
  belongs_to :user
end
