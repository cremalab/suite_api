class Vote < ActiveRecord::Base
  #Relationships
  belongs_to :idea
  belongs_to :user

  before_destroy :swan_song

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

  def swan_song
    # Let Faye know it's about to go bye-bye
    delete_json = "{\"model_name\": \"Vote\", \"deleted\": true, \"id\": #{id}}"
    PrivatePub.publish_to("/message/channel", message: delete_json)
  end

end
