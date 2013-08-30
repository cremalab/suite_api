class Vote < ActiveRecord::Base
  #Relationships
  has_one :alternate, foreign_key: "vote_id"
  belongs_to :idea
  belongs_to :user

  #Validations
  validates_presence_of :idea_id, :user_id, :vote

end
