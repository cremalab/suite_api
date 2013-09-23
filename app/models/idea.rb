class Idea < ActiveRecord::Base
  #Relationships
  has_many :votes, foreign_key: "idea_id", autosave: true, dependent: :destroy, validate: false
  belongs_to :idea_thread
  belongs_to :user

  #Validations
  validates_presence_of :title, :user_id
  validate :validate_voting_right, on: :create
  # accepts_nested_attributes_for :votes, allow_destroy: true

  def first_in_thread?
    self == self.idea_thread.ideas.order("created_at ASC").first
  end

private
  def validate_voting_right
    if idea_thread_id
      has_voting_right = idea_thread.voter_ids.include?(user_id)
      errors.add(:base, "You do not have permission to add an idea to this thread") unless has_voting_right
    end
  end
end
