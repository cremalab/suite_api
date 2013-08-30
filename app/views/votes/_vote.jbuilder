json.(vote, :idea_id, :user_id, :created_at, :id)
json.user do
  json.id vote.user_id
  json.email vote.user.email
end
json.user_vote @current_auth_user.id == vote.user_id