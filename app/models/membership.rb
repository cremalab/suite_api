class Membership < ActiveRecord::Base
  #Relationships
  belongs_to :user
  belongs_to :groups

  #Validation
  validates_presence_of :user_id


end
