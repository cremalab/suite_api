require 'test_helper'

class IdeaTest < ActiveSupport::TestCase
  def setup
    @user = users(:rob)
    @idea_thread = IdeaThread.new()
    @idea_thread.voters << @user
    @idea_thread.status = "open"
    @idea_thread.title = "Sandwich"
    @idea_thread.save

    @new_idea_attr = {title: "Meatloaf at YJ's",
                      idea_thread_id: @idea_thread.id,
                      description: "Mmmmm... eatloaf", user_id: @user.id,
                    }
  end


  test "create_associated_vote" do
    assert false, "I need a test! Waaaaa!"
  end

  test "delete_message" do
    assert false, "I need a test! Waaaaa!"
  end


  test "email list" do
    idea = ideas(:milkshakes)
    list = idea.email_list

    assert_equal list, ["ross@poop.com", "michael@theverge.com"]
  end


  test "first_in_thread?" do
    assert false, "I need a test! Waaaaa!"
  end

  test "message" do
    assert false, "I need a test! Waaaaa!"
  end

  test "recent_activities" do
    assert false, "I need a test! Waaaaa!"
  end

  test "related activities" do
    idea = Idea.create(@new_idea_attr)
    idea.create_activity :create, owner: @user

    idea.related_activities.count.must_equal 1
    @idea_thread.related_activities.count.must_equal 1
  end

  test "voting rights" do
    @idea_thread.voters.destroy_all
    new_idea = Idea.new(@new_idea_attr)
    refute new_idea.valid?
  end

end
