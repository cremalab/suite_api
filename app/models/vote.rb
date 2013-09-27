class Vote < ActiveRecord::Base
  #Relationships
  belongs_to :idea
  belongs_to :user

  #Validations
  validate :validate_voting_right
  validates_presence_of :idea_id, :user_id

private
  def validate_voting_right
    if idea_id
      idea = Idea.find(idea_id)
      voting_right = VotingRight.where(idea_thread_id: idea.idea_thread_id, user_id: user_id)
      errors.add(:base, "no permission") if voting_right.empty?
    end
  end

end
