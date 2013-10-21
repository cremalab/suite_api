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
  end

  def delete_message
    j = {comment: self, id: self.id, model_name: "comment", deleted: true}
    PrivatePub.publish_to("/message/channel", message: j)

  end
end
