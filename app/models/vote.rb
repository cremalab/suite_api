# vote.rb
# Public:
#
# Example:
class Vote < ActiveRecord::Base
  # Activity Tracking
  include PublicActivity::Common

  #Relationships
  belongs_to :idea
  belongs_to :user

  before_destroy :swan_song

  #Validations
  validate :validate_voting_right
  validates_presence_of :idea_id, :user_id


  def message
    p self.idea.idea_thread.voting_rights.map {|a| a.voter.email}
    emails = self.idea.idea_thread.voting_rights.map {|a| a.voter.email}
    #Notifier.new_vote(emails).deliver

    PrivatePub.publish_to("/message/channel", message: self.to_json)
    # Activity Feed
    activity = self.create_activity :create, owner: self.user, recipient: self.idea
    activity_json = PublicActivity::ActivitySerializer.new(activity).to_json
    PrivatePub.publish_to("/message/channel", message: activity_json)
  end

private
  def validate_voting_right
    if idea_id
      idea = Idea.find(idea_id)
      voting_right = VotingRight.where( idea_thread_id: idea.idea_thread_id,
                                        user_id: user_id)
      errors.add(:base, "no permission") if voting_right.empty?
    end
  end

  def swan_song
    # Let Faye know it's about to go bye-bye
    delete_json = "{\"model_name\": \"Vote\", \"deleted\": true, \"id\": #{id}}"
    PrivatePub.publish_to("/message/channel", message: delete_json)
  end


end
