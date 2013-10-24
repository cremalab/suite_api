# idea_thread.rb
# Public:
#
# Example:
class IdeaThread < ActiveRecord::Base
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
    emails = self.voting_rights.map {|a| a.voter.email}
    #Notifier.new_thread(emails).deliver
    PrivatePub.publish_to("/message/channel", message: self.to_json)
  end

  def check_emails
    #If the user wants emails (user.noification_settings.idea_thread == true)
    #Then add to the list
    #self.voting_rights.each |user|

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



private
  def validate_voting_rights
    errors.add(:voting_rights, "are required") if voting_rights.length < 1
  end

end
