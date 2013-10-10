# Public: Comments are a part of idea. They help discuss the idea being used.
#
#
#
class Comment < ActiveRecord::Base
  belongs_to :idea
  belongs_to :user
end
