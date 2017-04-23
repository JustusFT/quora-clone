class Vote < ActiveRecord::Base
  validates :user_id, presence: true
  validates :voting_id, presence: true
  validates :type, presence: true
  validates :vote_type, presence: true

  belongs_to :user
  belongs_to :voting, :class_name => 'Vote', :foreign_key => 'voting_id'
end
