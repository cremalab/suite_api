class Group < ActiveRecord::Base
  has_many :memberships, foreign_key: "group_id"
  has_many :users, through: :memberships
  belongs_to :owner, class_name: 'User'
end
