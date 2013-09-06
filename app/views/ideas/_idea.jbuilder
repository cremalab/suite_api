json.(idea, :id, :title, :description, :when, :idea_thread_id, :user_id)
json.total_votes idea.votes.count
json.user do
  json.email idea.user.email
  json.id idea.user.id
end

json.votes idea.votes, partial: '/votes/vote', as: :vote