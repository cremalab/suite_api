# member.rb
# Public:
#
# Example:
class Membership < ActiveRecord::Base
  #Relationships
  belongs_to :group
  belongs_to :user

  #Validation
  validates_presence_of :user_id

end
