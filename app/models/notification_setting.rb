# Public:
#
# Example:
class NotificationSetting < ActiveRecord::Base
  belongs_to :user

  validates_inclusion_of :vote, :idea, :idea_thread, :sound, in: [true, false]

end
