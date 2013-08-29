class Vote < ActiveRecord::Base
  #Relationships
  has_one :alternate, foreign_key: "vote_id"
  belongs_to :idea

  #Validations
  validates_presence_of :idea_id, :user_id, :vote

end
