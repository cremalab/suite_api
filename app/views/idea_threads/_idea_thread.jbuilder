json.(idea_thread, :id, :title, :created_at, :updated_at, :user_id)
json.original_idea_id idea_thread.ideas.order("created_at ASC").first.id
json.ideas idea_thread.ideas, partial: '/ideas/idea', as: :idea
json.model_name "IdeaThread"
json.voting_rights idea_thread.voting_rights, partial: '/voting_rights/voting_right', as: :voting_right
