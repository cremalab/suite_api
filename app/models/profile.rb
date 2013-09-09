class Profile < ActiveRecord::Base
  #Relationships
  belongs_to :users

  #Validations
  validates_presence_of :first_name, :last_name, :user_id
end
