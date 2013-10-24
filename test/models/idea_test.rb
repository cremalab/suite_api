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

  test "validation" do
    #With all necessary values
    new_idea = Idea.new(@new_idea_attr)
    assert new_idea.valid?
  end

  test "presence of title" do
    new_idea = Idea.new(@new_idea_attr)
    new_idea.title = nil
    refute new_idea.valid?
  end

  test "presence of user id" do
    new_idea = Idea.new(@new_idea_attr)
    new_idea.user_id = nil
    refute new_idea.valid?
  end

  test "voting rights" do
    @idea_thread.voters.destroy_all
    new_idea = Idea.new(@new_idea_attr)
    refute new_idea.valid?
  end

  test "related activities" do
    idea = Idea.create(@new_idea_attr)
    idea.create_activity :create, owner: @user

    idea.related_activities.count.must_equal 1
    @idea_thread.related_activities.count.must_equal 1
  end

  test "email list" do
    idea = ideas(:milkshakes)
    list = idea.email_list

    assert_equal list, ["ross@poop.com", "michael@theverge.com"]

  end

end
