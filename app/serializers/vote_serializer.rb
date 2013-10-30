# Public:
#
# Example:
#
#
#
#
#
class VoteSerializer < ActiveModel::Serializer
  attributes :idea_id, :user_id, :created_at, :id, :model_name, :idea_thread_id

  has_one :user

  def model_name
    "Vote"
  end

  def idea_thread_id
    @object.idea.idea_thread.id
  end
end
