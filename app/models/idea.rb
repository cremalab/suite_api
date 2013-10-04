class Idea < ActiveRecord::Base
  #Relationships
  has_many  :votes, foreign_key: "idea_id",
              autosave: true, dependent: :destroy,
              validate: false

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

private
  def validate_voting_right
    if idea_thread_id
      has_voting_right = idea_thread.voter_ids.include?(user_id)
      warning_text = "You do not have permission to add an idea to this thread"
      errors.add(:base, warning_text) unless has_voting_right
    end
  end
end
