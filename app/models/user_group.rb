class UserGroup < ActiveRecord::Base
  has_many :users, foreign_key: "user_group_id"
end
