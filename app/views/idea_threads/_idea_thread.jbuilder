json.(idea_thread, :id, :created_at, :updated_at)
json.original_idea_id idea_thread.ideas.order("created_at ASC").first.id
json.ideas idea_thread.ideas, partial: '/ideas/idea', as: :idea