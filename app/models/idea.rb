# idea.rb
# Public:
#
# Example:
#
#
class Idea < ActiveRecord::Base

  # Activity Tracking
  include PublicActivity::Common

  #Relationships
  has_many  :votes, foreign_key: "idea_id",
              autosave: true, dependent: :destroy,
              validate: false
  has_many :comments, foreign_key: "idea_id"

  belongs_to :idea_thread
  belongs_to :user

  accepts_nested_attributes_for :votes, allow_destroy: true


  #Validations
  validate :validate_voting_right, on: :create
  # validates_associated :votes

  validates_presence_of :title, :user_id

  def create_associated_vote
    vote    = Vote.new(idea_id: self.id, user_id: self.user_id)
    checker = UserVoteChecker.new
    checker.create_vote(vote)
  end

  def delete_message
    message =  {
                        comment: self,
                        id: self.id,
                        model_name: "Idea",
                        deleted: true
                      }
    PrivatePub.publish_to("/message/channel", message: message.to_json)
  end

  def email_list
    email_list = []
    self.idea_thread.voting_rights.each do |vr|
      voter = vr.voter
      if voter.notification_setting.idea
        email_list << voter.email
      end

    end
    return email_list
  end

  def first_in_thread?
    idea_thred = self.idea_thread
    if idea_thread
      self == idea_thread.ideas.order("created_at ASC").first
    end
  end

  def message
    emails = self.email_list
    if emails.any?
      Notifier.new_idea(emails, self).deliver
    end
    idea_json = IdeaSerializer.new(self).to_json
    PrivatePub.publish_to("/message/channel", message: idea_json)
    # Activity Feed
    is_new = self.updated_at == self.created_at
    action = is_new ? :create : :update
    activity = self.create_activity action, owner: self.user
    activity_json = PublicActivity::ActivitySerializer.new(activity).to_json
    PrivatePub.publish_to("/message/channel", message: activity_json)
  end

  def num_votes
    self.votes.length
  end

  def recent_activities
    related_activities.limit(10)
  end

  def related_activities
    activities = PublicActivity::Activity.where("
      recipient_type = 'Idea' AND recipient_id = #{id}
      OR
      trackable_type = 'Idea' AND trackable_id = #{id}
    ").order("created_at DESC")
  end



private
  def validate_voting_right
    if idea_thread_id
      has_voting_right = idea_thread.voter_ids.include?(user_id)
      warning_text = "You do not have permission to add an idea to this thread"
      errors.add(:base, warning_text) unless has_voting_right
    end
  end
end
