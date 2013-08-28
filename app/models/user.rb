class User < ActiveRecord::Base
  authenticates_with_sorcery!

  #Relationships
  has_one :profile, foreign_key: "user_id"
  has_many :ideas, foreign_key: "user_id"


  #Validations
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :password_confirmation, :on => :create

  validates_presence_of :email
  validates_uniqueness_of :email

  accepts_nested_attributes_for :profile



end
