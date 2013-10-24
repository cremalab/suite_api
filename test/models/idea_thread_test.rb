require 'test_helper'

class IdeaThreadTest < ActiveSupport::TestCase
  def setup
    @user = users(:rob)
    @new_idea_thread_attr = {
      status: "open",
      title: "Yeah",
      voting_rights_attributes: [{user_id: @user.id}],
      ideas_attributes: [{title: "Get", user_id: @user.id}]
    }

  end

  test "validations" do
    #With all necessary values
    new_idea_thread = IdeaThread.new(@new_idea_thread_attr)
    assert new_idea_thread.valid?
  end

  test "voting rights" do
    new_idea_thread = IdeaThread.new(@new_idea_thread_attr)
    new_idea_thread.voting_rights.destroy_all
    refute new_idea_thread.valid?
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

end
