class VotingRight < ActiveRecord::Base
  belongs_to :idea_thread
  belongs_to :voter, foreign_key: 'user_id', class_name: 'User'
end
