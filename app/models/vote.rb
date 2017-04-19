class Vote < ActiveRecord::Base
  # abstract class; not a real table
  # however, all vote-related models inherit this class
  self.abstract_class = true

  validates :user_id, presence: true
  validates :vote_type, presence: true
  belongs_to :user
end
