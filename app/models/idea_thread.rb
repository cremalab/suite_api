class IdeaThread < ActiveRecord::Base
  #Relationships
  has_many :ideas, dependent: :destroy
  has_many :voting_rights
  has_many :voters, through: :voting_rights, foreign_key: 'idea_thread_id', class_name: 'User'
  belongs_to :user

  #Validations
  validate :validate_voting_rights


  accepts_nested_attributes_for :ideas
  accepts_nested_attributes_for :voting_rights

private
  def validate_voting_rights
    errors.add(:voting_rights, "are required") if voting_rights.length < 1
  end

end
