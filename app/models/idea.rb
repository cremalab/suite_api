class Idea < ActiveRecord::Base
  #Relationships
  belongs_to :idea_thread
  has_many :votes, foreign_key: "idea_id", autosave: true, dependent: :destroy, validate: false
  belongs_to :user

  #Validations
  validates_presence_of :title, :when, :user_id

  accepts_nested_attributes_for :votes, allow_destroy: true


end
