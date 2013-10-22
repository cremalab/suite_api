# notifier.rb
# Public:
#
# Example:
#
#
#
class Notifier < ActionMailer::Base
  default :from => 'no-reply@vot.io'

  def new_thread(user)
    mail( :to => user.email,
    :subject => 'New Thread Created' )
  end

  def new_idea(user)
    mail( :to => user.email,
    :subject => 'New Idea Created' )
  end

  def new_vote(user)
    mail( :to => user.email,
    :subject => 'New Vote Created' )
  end


end