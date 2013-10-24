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

  has_one :user

  def model_name
    "Vote"
  end
end
