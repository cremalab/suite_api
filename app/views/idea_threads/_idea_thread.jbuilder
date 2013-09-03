json.(idea_thread, :id, :created_at, :updated_at)
json.ideas idea_thread.ideas, partial: '/ideas/idea', as: :idea