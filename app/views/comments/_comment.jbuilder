json.(comment, :id, :content, :created_at, :updated_at, :user_id, :idea_id)
json.user_name comment.user.display_name
json.model_name "Comment"