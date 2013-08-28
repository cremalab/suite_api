class IdeaVote < ActiveRecord::Base
  #Relationships
  belongs_to :idea

  #Validations
  validates_presence_of :idea_id, :user_id

end
