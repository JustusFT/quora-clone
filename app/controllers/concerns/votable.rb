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

    # CURRENT TABLES
    # question_votes:
    # question_id | vote_type  | user_id
    # ------------+------------+--------
    # 1           | "upvote"   | 1
    # 2           | "downvote" | 1

    # answer_votes:
    # answer_id   | vote_type  | user_id
    # ------------+------------+--------
    # 1           | "upvote"   | 1
    # 2           | "downvote" | 1
    #
    # PROPOSED STI TABLE
    #     TYPE   | VOTE_TYPE  | BELOINGS_TO_ID | USER_ID
    # -----------+------------+----------------+---------
    # "Question" | "upvote"   | 1              | 1
    # "Answer"   | "downvote" | 1              | 1
    # "Question" | "upvote"   | 2              | 1
    # "Comment"  | "downvote" | 4              | 1
    #
    # Where:
    #   type = what the user is voting (QuestionVote vs AnswerVote vs CommentVote)
    #   vote_type = "upvote" or "downvote"
    #   belongs_to_id = the id
    #
    # why?
    #   having them all in the same table, where they are distinguished by type
    #   this sorta works like duck typing, when given all the same column name (BELOINGS_TO_ID)
    #   this enables me to use string interpolation in a query, rathar than using send()
    #
    # QUESTION:
    #   what about performance? if all votes are in a single table, you have to search through irrelevant votes
    #     so isn't this terrible for performance? can indexing help?
    #   how is string inerpolation with a longer query better than send?
    def vote(user, vote_type)
      # PROPOSED VOTE FUNCTION
      #in this case, type: type could be type: "question" or type: "answer"
      # e.g. user.votes.find_by(type: "ANSWER", belongs_to_id: self.id).nil?
      # unless user.votes.find_by(type: type, belongs_to_id: self.id).nil?
      #
      # else
      #
      # end

      # CURRENT VOTE FUNCTION
      # uses send() to get the correct infrmation
      # e.g. user.send("QUESTION_votes").find_by("QUESTION_id": self.id).nil?
      # ==   user.QUESTION_votes.find_by("QUESTION_id": self.id).nil?
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
