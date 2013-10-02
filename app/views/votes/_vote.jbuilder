json.(vote, :idea_id, :user_id, :created_at, :id)
json.thread_id vote.idea.idea_thread_id
json.user do
  json.id vote.user_id
  json.email vote.user.email
  #json.profile do |json|
  #  json.first_name vote.user.profile.first_name
  #  json.last_name vote.user.profile.last_name
  #end
end
json.model_name "Vote"