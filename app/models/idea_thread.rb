class IdeaThread < ActiveRecord::Base
  #Relationships
  has_many :ideas, dependent: :destroy, dependent: :destroy
  has_many :votes, through: :ideas, foreign_key: 'idea_thread_id'
  has_many :voting_rights, dependent: :destroy
  has_many :voters, through: :voting_rights, foreign_key: 'idea_thread_id', class_name: 'User'
  belongs_to :user

  #Validations
  validate :validate_voting_rights
  validates_presence_of :title

  #Status
  symbolize :status, :in => [:open, :archived], :scopes => true, default: :open


  accepts_nested_attributes_for :ideas
  accepts_nested_attributes_for :voting_rights

private
  def validate_voting_rights
    errors.add(:voting_rights, "are required") if voting_rights.length < 1
  end

end
