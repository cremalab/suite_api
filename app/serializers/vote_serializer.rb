# Public:
#
# Example:
#
#
#
#
#
class VoteSerializer < ActiveModel::Serializer
  attributes :idea_id, :user_id, :created_at, :id, :model_name

  def model_name
    "Vote"
  end
end
