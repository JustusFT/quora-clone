class Question < ActiveRecord::Base
  validates :title, presence: true
  validates :user_id, presence: true
  has_many :answers
  belongs_to :user

  include Votable
end
