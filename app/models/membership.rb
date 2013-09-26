class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :groups

  #Validation
  validates :user_id, presence: true


end
