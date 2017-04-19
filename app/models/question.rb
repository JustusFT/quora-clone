class Question < ActiveRecord::Base
  validates :title, presence: true
  has_many :question_votes
  has_many :answers

  include Votable
end
