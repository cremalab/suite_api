json.(voting_right, :idea_thread_id, :user_id, :created_at, :id)
json.autocomplete_value voting_right.user_id
json.autocomplete_search voting_right.voter.display_name