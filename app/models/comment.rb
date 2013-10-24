# comment.rb
# Public: Comments are a part of idea. They help discuss the idea being used.
#
#
# Example:
#
#
#
class Comment < ActiveRecord::Base
  # Activity Tracking
  include PublicActivity::Common

  belongs_to :idea
  belongs_to :user

  def message
    comment_json = CommentSerializer.new(self).to_json
    PrivatePub.publish_to("/message/channel", message: comment_json)
    # Activity Feed
    activity = self.create_activity :create, owner: self.user, recipient: self.idea,
      parameters: {content: self.content}

    activity_json = PublicActivity::ActivitySerializer.new(activity).to_json
    PrivatePub.publish_to("/message/channel", message: activity_json)
  end

  def delete_message
    delete_message =  {
                        comment: self,
                        id: self.id,
                        model_name: "comment",
                        deleted: true
                      }
    PrivatePub.publish_to("/message/channel", message: delete_message)

  end
end
