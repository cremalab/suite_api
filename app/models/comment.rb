# Public: Comments are a part of idea. They help discuss the idea being used.
#
#
#
class Comment < ActiveRecord::Base
  # Activity Tracking
  include PublicActivity::Common

  belongs_to :idea
  belongs_to :user

  def message
    PrivatePub.publish_to("/message/channel", message: self.to_json)
    # Activity Feed
    activity = self.create_activity :create, owner: self.user, recipient: self.idea

    activity_json = PublicActivity::ActivitySerializer.new(activity).to_json
    PrivatePub.publish_to("/message/channel", message: activity_json)
  end

  def delete_message
    j = {comment: self, id: self.id, model_name: "comment", deleted: true}
    PrivatePub.publish_to("/message/channel", message: j)

  end
end
