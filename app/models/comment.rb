# Public: Comments are a part of idea. They help discuss the idea being used.
#
#
#
class Comment < ActiveRecord::Base
  # Activity Tracking
  include PublicActivity::Common

  belongs_to :idea
  belongs_to :user
end
