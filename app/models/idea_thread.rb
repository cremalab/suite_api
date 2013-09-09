class IdeaThread < ActiveRecord::Base
  #Relationships
  has_many :ideas, dependent: :destroy
  belongs_to :user

  #Validations
  validates_presence_of :user_id
  accepts_nested_attributes_for :ideas
end
