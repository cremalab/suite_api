# Public:
#
# Example:
#
#
#
#
#
class IdeaSerializer < ActiveModel::Serializer
  attributes  :id, :title, :description, :idea_thread_id, :user_id,
              :updated_at, :created_at, :total_votes, :original, :model_name,
              :comment_count

  has_many :votes
  has_many :recent_activities
  has_one :user

  def comment_count
    object.comments.size
  end

  def model_name
    "Idea"
  end

  def original
    object.first_in_thread?
  end

  def total_votes
    object.votes.count
  end

  def recent_activities
    object.recent_activities
  end

end
