# Public:
#
# Example:
#
#
#
#
#
class IdeaThreadSerializer < ActiveModel::Serializer
  attributes  :id, :title, :created_at, :updated_at, :user_id, :status,
              :description, :expiration, :original_idea_id, :model_name,
              :user_name

  has_many :ideas, :voting_rights, :related_activities

  def original_idea_id
    ideas = object.ideas
    ideas.order("created_at ASC").first.id if ideas.any?
  end

  def model_name
    "IdeaThread"
  end

  def user_name
    object.user.display_name
  end

  def related_activities
    # Alias this method so only last 10 are delivered
    # in this JSON payload
    object.recent_activities
  end
end
