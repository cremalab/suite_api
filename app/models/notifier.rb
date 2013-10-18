# notifier.rb
# Public:
#
# Example:
class Notifier < ActionMailer::Base
  default :from => 'no-reply@vot.io'

  def new_thread(user)
    mail( :to => user.email,
    :subject => 'New Thread Created' )
  end
end