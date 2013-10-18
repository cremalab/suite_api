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

  has_many :ideas, :voting_rights

  def original_idea_id
    object.ideas.order("created_at ASC").first.id if object.ideas.any?
  end

  def model_name
    "IdeaThread"
  end

  def user_name
    object.user.display_name
  end
end
