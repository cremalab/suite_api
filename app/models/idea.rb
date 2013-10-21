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

  def first_in_thread?
    self == self.idea_thread.ideas.order("created_at ASC").first
  end

  def create_associated_vote
    vote    = Vote.new(idea_id: self.id, user_id: self.user_id)
    checker = UserVoteChecker.new
    checker.create_vote(vote)
  end

  def message
    PrivatePub.publish_to("/message/channel", message: self.to_json)
  end

  def delete_message
    j = {comment: self, id: self.id, model_name: "idea", deleted: true}
    PrivatePub.publish_to("/message/channel", message: j)
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
