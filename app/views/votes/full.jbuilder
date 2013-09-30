json.partial! 'vote', vote: @vote
json.idea_title @vote.idea.title
json.thread_title @vote.idea.idea_thread.title
json.user_name @vote.user.display_name