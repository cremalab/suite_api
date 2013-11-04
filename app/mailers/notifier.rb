# notifier.rb
# Public:
#
# Example:
#
#
#
class Notifier < ActionMailer::Base
  default :from => 'no-reply@vot.io'

  def app_url
    if Rails.env == 'development'
      "http://localhost:3333"
    else
      "http://cremalab-ideas.herokuapp.com"
    end
  end

  def new_thread(emails, thread)
    @app_url = app_url
    @thread = thread
    @thread_user = @thread.user
    mail( bcc: emails, subject: 'New Thread Created')
  end

  def new_idea(emails, idea)
    @idea = idea
    @idea_user = @idea.user
    @thread = @idea.idea_thread
    @app_url = app_url
    mail( bcc: emails, subject: 'New Idea Created' )
  end

  def new_vote(emails, vote)
    @vote = vote
    @vote_user = @vote.user
    @idea = @vote.idea
    @thread = @idea.idea_thread
    @app_url = app_url
    mail( bcc: emails, subject: 'New Vote Created' )
  end
end