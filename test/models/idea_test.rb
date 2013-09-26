require 'test_helper'

class IdeaTest < ActiveSupport::TestCase
  def setup
    @user = users(:rob)
    @idea_thread = IdeaThread.new()
    @idea_thread.voters << @user
    @idea_thread.status = "open"
    @idea_thread.title = "Sandwich"
    @idea_thread.save
  end

  test "validation" do
    new_idea_attr = {title: "Meatloaf at YJ's",
                      idea_thread_id: @idea_thread.id,
                      when: "2013-08-28 09:26:06 -0500",
                      description: "Mmmmm... eatloaf", user_id: @user.id,
                    }

    new_idea = Idea.new(new_idea_attr)
    assert new_idea.valid?

    new_idea.title = nil
    refute new_idea.valid?

    new_idea = Idea.new(new_idea_attr)
    new_idea.user_id = nil
    refute new_idea.valid?

    @idea_thread.voters.destroy_all
    new_idea = Idea.new(new_idea_attr)
    refute new_idea.valid?


  end
end
