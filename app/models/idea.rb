class Idea < ActiveRecord::Base
  #Relationships
  has_many :votes, foreign_key: "idea_id", autosave: true, dependent: :destroy, validate: false
  belongs_to :idea_thread
  belongs_to :user

  #Validations
  validates_presence_of :title, :user_id, :idea_thread_id
  accepts_nested_attributes_for :votes, allow_destroy: true


end
