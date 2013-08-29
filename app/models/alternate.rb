class Alternate < ActiveRecord::Base
  #Relationships
  belongs_to :vote

  #Validations
  validates_presence_of :alternate, :vote_id
end
