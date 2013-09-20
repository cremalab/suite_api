class Vote < ActiveRecord::Base
  #Relationships
  has_one :alternate, foreign_key: "vote_id"
  belongs_to :idea
  belongs_to :user

  #Validations
  validates_presence_of :idea_id, :user_id
  validate :validate_voting_right

private
  def validate_voting_right
    if idea_id
      idea = Idea.find(idea_id)
      voting_right = VotingRight.where(idea_thread_id: idea.idea_thread_id, user_id: user_id)
      errors.add(:base, "no permission") if voting_right.empty?
    end
  end

end
