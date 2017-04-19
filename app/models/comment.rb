class Comment < ActiveRecord::Base
  validates :comment, presence: true
  validates :user_id, presence: true
  validates :answer_id, presence: true
  belongs_to :user
  belongs_to :answer

  include Votable
end
