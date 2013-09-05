class IdeaThread < ActiveRecord::Base
  #Relationships
  has_many :ideas, foreign_key: "idea_thread_id"
  belongs_to :users

  #Validations
  validates_presence_of :user_id
  accepts_nested_attributes_for :ideas

  #Live Stream
  #after_save
  #after_destroy
end