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
end
