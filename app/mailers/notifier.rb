# notifier.rb
# Public:
#
# Example:
#
#
#
class Notifier < ActionMailer::Base
  default :from => 'no-reply@vot.io'

  def new_thread(emails)
    mail( to: emails, subject: 'New Thread Created')
  end

  def new_idea(emails)
    mail( to: emails, subject: 'New Idea Created' )
  end

  def new_vote(emails)
    mail( to: emails, subject: 'New Vote Created' )
  end
end