json.(idea_thread, :id)
json.ideas idea_thread.ideas, partial: '/ideas/idea', as: :idea