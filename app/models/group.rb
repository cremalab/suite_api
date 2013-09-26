class Group < ActiveRecord::Base
  #Relationships
  has_many :memberships, foreign_key: "group_id"
  has_many :users, through: :memberships
  belongs_to :owner, class_name: 'User'

  accepts_nested_attributes_for :memberships

  #Validation
end
