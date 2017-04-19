require 'active_support/concern'

module Votable
  extend ActiveSupport::Concern

  included do
    validates :user_id, presence: true
    belongs_to :user

    # e.g. Question => "question"
    def type
      self.class.to_s.downcase
    end

    # e.g. "question" => QuestionVote
    def vote_model
      "#{type.titleize}Vote".constantize
    end

    # subtract upvotes from downvotes
    def rating
      self.send("#{type}_votes").where(vote_type: "upvote").count - self.send("#{type}_votes").where(vote_type: "downvote").count
    end

    def vote(user, vote_type)
      unless user.send("#{type}_votes").find_by("#{type}_id": self.id).nil?
        vote = user.send("#{type}_votes").find_by("#{type}_id": self.id)
      else
        vote = vote_model.new
      end
      vote.send("#{type}_id=", id)
      vote.user_id = user.id
      vote.vote_type = vote_type
      return vote.save
    end

    def remove_vote(user, id)
      vote = self.send("#{type}_votes").find_by(user_id: user.id)
      return vote.destroy
    end
  end
end
