require 'active_support/concern'

module Votable
  extend ActiveSupport::Concern

  included do
    has_many :votes, :foreign_key => "voting_id",  :class_name => 'Vote'
    validates :user_id, presence: true
    belongs_to :user

    # e.g. Question => "QuestionVote"
    def model_type
      "#{self.class.to_s}Vote"
    end

    # subtract upvotes from downvotes
    def rating
      Vote.where(type: model_type, vote_type: "upvote", voting_id: self.id).count - Vote.where(type: model_type, vote_type: "downvote", voting_id: self.id).count
    end

    # e.g. Question.vote(1, "upvote")
    def vote(user, vote_type)
      # find if vote already exists
      vote = user.votes.find_by(type: model_type, voting_id: self.id)
      # otherwise make a new vote
      vote = Vote.new if vote.nil?

      vote.attributes = ({
        user_id: user.id,
        type: model_type,
        voting_id: self.id,
        vote_type: vote_type
      })
      return vote.save
    end

    def remove_vote(user, id)
      vote = self.votes.find_by(type: model_type, voting_id: id, user_id: user.id)
      return vote.destroy
    end
  end
end
