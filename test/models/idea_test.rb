require 'test_helper'

class IdeaTest < ActiveSupport::TestCase
  test "validation" do
    new_idea_attr = {title: "Meatloaf at YJ's",
                      when: "2013-08-28 09:26:06 -0500",
                      description: "Mmmmm... eatloaf", user_id: 1}

    new_idea = Idea.new(new_idea_attr)
    new_idea.title = nil
    refute new_idea.valid?

    new_idea = Idea.new(new_idea_attr)
    new_idea.when = nil
    refute new_idea.valid?

    new_idea = Idea.new(new_idea_attr)
    new_idea.user_id = nil
    refute new_idea.valid?

    new_idea = Idea.new(new_idea_attr)
    assert new_idea.valid?


  end
end
