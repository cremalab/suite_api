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
  has_many :related_activities
  has_one :user

  def total_votes
    object.votes.count
  end

  def original
    object.first_in_thread?
  end

  def model_name
    "Idea"
  end

  def related_activities
    # Alias this method so only last 10 are delivered
    # in this JSON payload
    object.recent_activities
  end

  def comment_count
    object.comments.size
  end

end
