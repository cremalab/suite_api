class Idea < ActiveRecord::Base
  #Relationships
  has_many :votes, foreign_key: "idea_id"
  belongs_to :users

  #Validations
  validates_presence_of :title, :when, :user_id

  accepts_nested_attributes_for :votes


end
