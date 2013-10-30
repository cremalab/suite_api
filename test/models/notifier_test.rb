require 'test_helper'

class NotifierTest < ActiveSupport::TestCase

  def setup
    @user = users(:rob)
    @thread = idea_threads(:lunch)
    @idea = ideas(:sandwich)
    @vote = votes(:rob_vote_sandwich)
  end

  test "new_thread" do
    thread = idea_threads()
    Notifier.new_thread(["mattowens11@gmail.com"], @thread).deliver
    mail = ActionMailer::Base.deliveries.last

    assert_includes mail.body, "Put on your thinkin' caps!"
  end

  test "new_idea" do
    Notifier.new_idea(["mattowens11@gmail.com"], @idea).deliver
    mail = ActionMailer::Base.deliveries.last

    assert_includes mail.body, "Rob LaFeve"
    assert_includes mail.body, "Lunch:"
    assert_includes mail.body, "Chicken Salad Sandwiches at Sylvias"

  end

  test "new_vote" do
    Notifier.new_vote(["mattowens11@gmail.com"], @vote).deliver
    mail = ActionMailer::Base.deliveries.last

    assert_includes mail.body, "Rob LaFeve"
    assert_includes mail.body, "Chicken Salad Sandwiches at Sylvias"

  end

end