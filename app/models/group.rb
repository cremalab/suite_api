class Group < ActiveRecord::Base
  has_many :user_groups, foreign_key: "group_id"
  has_many :users, through: :user_groups
end
