require 'test_helper'

class NotifierTest < ActiveSupport::TestCase

  test "new_thread" do
    Notifier.new_thread(["mattowens11@gmail.com"]).deliver
    mail = ActionMailer::Base.deliveries.last

    assert_includes mail.body, "Put on your thinkin' caps!"
  end

  test "new_idea" do
    Notifier.new_idea(["mattowens11@gmail.com"]).deliver
    mail = ActionMailer::Base.deliveries.last

    assert_includes mail.body, "New idea! Or updated idea!"

  end

  test "new_vote" do
    Notifier.new_vote(["mattowens11@gmail.com"]).deliver
    mail = ActionMailer::Base.deliveries.last

    assert_includes mail.body, "New vote!"

  end

end