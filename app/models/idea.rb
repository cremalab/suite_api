class Idea < ActiveRecord::Base
  #Relationships
<<<<<<< HEAD
  has_many :votes, foreign_key: "idea_id"
  belongs_to :users
  belongs_to :idea_thread
=======
  has_many :votes, foreign_key: "idea_id", autosave: true, dependent: :destroy, validate: false
  belongs_to :user
>>>>>>> ab389f648957baaf7c33304b94637032c0ad62a0

  #Validations
  validates_presence_of :title, :when, :user_id

  accepts_nested_attributes_for :votes, allow_destroy: true


end
