require 'test_helper'

class IdeaThreadTest < ActiveSupport::TestCase
  def setup
    @user = users(:rob)
    @new_idea_thread_attr = {
      status: "open",
      title: "Yeah",
      user_id: @user.id,
      voting_rights_attributes: [{user_id: @user.id}],
      ideas_attributes: [{title: "Get", user_id: @user.id}]
    }

  end

  test "set_archive" do
    idea_thread = idea_threads(:fun)
    assert_equal idea_thread.status, :open
    idea_thread.set_archive
    assert_equal idea_thread.status, :archived
  end

  # test "delete_message" do
  #   assert false, "I need a test! Waaaaa!"
  # end

  test "email_list" do
    idea_thread = idea_threads(:fun)
    list = idea_thread.email_list
    assert_equal list, ["ross@poop.com", "michael@theverge.com"]
  end

  test "expiration_check" do
    idea_thread = idea_threads(:fun)
    idea_thread.expiration_check
    job = Delayed::Job.find_by(queue: idea_thread.id.to_s)
    assert_equal job.run_at, "2014-10-25 20:08:07"
  end

  test "message" do
    idea_thread = idea_threads(:fun)

    idea_thread.message

    mail = ActionMailer::Base.deliveries.last

    assert_includes mail.body, "Put on your thinkin' caps!"
  end

  test "recent_activities" do
    idea_thread = idea_threads(:fun)
    for i in 0..12
      idea_thread.create_activity :create, owner: idea_thread.user
    end
    assert_equal idea_thread.recent_activities.length, 10
  end

  test "related activities" do
    idea_thread = IdeaThread.create(@new_idea_thread_attr)
    idea_thread.message

    # Activity for thread creation
    idea_thread.related_activities.count.must_equal 1

    new_idea_attr = {title: "Meatloaf at YJ's",
                      idea_thread_id: idea_thread.id,
                      description: "Mmmmm... eatloaf", user_id: @user.id,
                    }

    idea = Idea.create(new_idea_attr)
    idea.message

    # Activity for idea creation
    idea.related_activities.count.must_equal 1
    idea_thread.related_activities.count.must_equal 2

    # Activity for vote creation
    idea.votes.create(user: @user)
    Vote.last.create_activity :create, owner: @user, recipient: idea
    Vote.last.activities.count.must_equal 1
    idea.related_activities.count.must_equal 2
    idea_thread.related_activities.count.must_equal 3
  end

  test "set_expiration" do
    idea_thread = idea_threads(:fun)
    idea_thread.set_expiration
    job = Delayed::Job.find_by(queue: idea_thread.id.to_s)
    assert_equal job.run_at, "2014-10-25 20:08:07"
  end

  test "update_expiration" do
    idea_thread = idea_threads(:fun)
    idea_thread.set_expiration
    job = Delayed::Job.find_by(queue: idea_thread.id.to_s)
    assert_equal job.run_at, "2014-10-25 20:08:07"

    idea_thread.expiration = "2015-10-25 20:08:07"
    idea_thread.update_expiration
    job = Delayed::Job.find_by(queue: idea_thread.id.to_s)

    assert_equal job.run_at, "2015-10-25 20:08:07"
  end

  test "voting rights" do
    new_idea_thread = IdeaThread.new(@new_idea_thread_attr)
    new_idea_thread.voting_rights.destroy_all
    refute new_idea_thread.valid?
  end

end
