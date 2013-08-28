class Profile < ActiveRecord::Base
  #Relationships
  belongs_to :users

  #Validations
end
