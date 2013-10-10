json.(idea, :id, :title, :description, :idea_thread_id, :user_id, :updated_at, :created_at)
json.total_votes idea.votes.count
json.user do
  json.email idea.user.email
  json.id idea.user.id
  json.profile do |json|
    json.first_name idea.user.profile.first_name
    json.last_name idea.user.profile.last_name
  end
end
json.original idea.first_in_thread?

json.votes idea.votes, partial: '/votes/vote', as: :vote
json.model_name "Idea"