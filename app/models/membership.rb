class Membership < ActiveRecord::Base
  #Relationships
  belongs_to :groups
  belongs_to :user

  #Validation
  validates_presence_of :user_id


end
