class CommentSerializer < ActiveModel::Serializer
  attributes  :id, :content, :created_at, :updated_at, :user_id, :idea_id,
              :user_name, :model_name

  def user_name
    object.user.display_name

  end

  def model_name
    "Comment"
  end


end
