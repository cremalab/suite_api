class IdeaSerializer < ActiveModel::Serializer
  attributes  :id, :title, :description, :idea_thread_id, :user_id,
              :updated_at, :created_at, :total_votes, :original, :model_name

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

end
