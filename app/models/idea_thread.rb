class IdeaThread < ActiveRecord::Base
  # Activity Tracking
  include PublicActivity::Common

  #Relationships
  has_many  :ideas, dependent: :destroy, dependent: :destroy
  has_many  :voting_rights, dependent: :destroy
  has_many  :voters, through: :voting_rights,
              foreign_key: 'idea_thread_id',
              class_name: 'User'
  has_many  :votes, through: :ideas, foreign_key: 'idea_thread_id'

  belongs_to :user

  accepts_nested_attributes_for :ideas
  accepts_nested_attributes_for :voting_rights


  #Validations
  validate :validate_voting_rights
  validates_associated :ideas, :votes, :voting_rights, :voters

  validates_presence_of :title

  #Status
  symbolize :status, :in => [:open, :archived], :scopes => true, default: :open

  def self.auto_archive(id)
    find(id).auto_archive
  end

  def auto_archive
    update_attribute(:status, :archived)
  end

  def set_expiration
    self.delay(run_at: expiration, queue: self.id).auto_archive(self.id)
  end

  def update_expiration
    expiration = @idea_thread.expiration
    id = self.id
    job = Delayed::Job.find_by(queue: id.to_s)
    if job
      job.delete
    end
    self.delay(run_at: expiration, queue: id).auto_archive(id)
  end

  def message
    PrivatePub.publish_to("/message/channel", message: self.to_json)
    is_new = self.updated_at == self.created_at
    action = is_new ? :create : :update
    activity = self.create_activity action, owner: self.user
    activity_json = PublicActivity::ActivitySerializer.new(activity).to_json
    PrivatePub.publish_to("/message/channel", message: activity_json)
  end

  def delete_message
    j = {comment: self, id: self.id, model_name: "idea_thread", deleted: true}
    PrivatePub.publish_to("/message/channel", message: j)

  end

  def related_activities
    activities = PublicActivity::Activity.where("
      trackable_type = 'IdeaThread' AND trackable_id = #{id}
      OR
      trackable_type = 'Idea' AND trackable_id IN (?)
      OR
      recipient_type = 'Idea' AND recipient_id IN (?)
    ", self.ideas.pluck(:id), self.ideas.pluck(:id) )
    activities.order("created_at DESC")
  end

  def recent_activities
    related_activities.limit(10)
  end



private
  def validate_voting_rights
    errors.add(:voting_rights, "are required") if voting_rights.length < 1
  end

end
