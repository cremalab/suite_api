# idea_thread.rb
# Public:
#
# Example:
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
    id = self.id
    self.delay(run_at: expiration, queue: id).auto_archive(id)
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
    emails = self.email_list

    thread_json = IdeaThreadSerializer.new(self).to_json
    PrivatePub.publish_to("/message/channel", message: thread_json)

    is_new = self.updated_at == self.created_at
    action = is_new ? :create : :update
    if emails.any? && action == :create
      Notifier.new_thread(emails).deliver
    end
    activity = self.create_activity action, owner: self.user
    activity_json = PublicActivity::ActivitySerializer.new(activity).to_json
    PrivatePub.publish_to("/message/channel", message: activity_json)
  end

  def email_list
    #If the user wants emails (user.noification_settings.idea_thread == true)
    #Then add to the list
    email_list = []
    self.voting_rights.each do |vr|
      if vr.voter.notification_setting.idea_thread
        email_list << vr.voter.email
      end

    end
    return email_list
  end

  def delete_message
    delete_message =  {
                        comment: self,
                        id: self.id,
                        model_name: "idea_thread",
                        deleted: true
                      }
    PrivatePub.publish_to("/message/channel", message: delete_message)

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
