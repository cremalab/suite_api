json.(idea, :id, :title, :description, :when)
json.total_votes idea.votes.count
json.user do
  json.email idea.user.email
  json.id idea.user.id
end
json.votes idea.votes do |vote|
  json.id vote.id
  json.created_at vote.created_at
  json.user_id vote.user_id
  json.user do
    json.email vote.user.email
    json.id vote.user_id
  end
end