require 'test_helper'

class IdeaThreadTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "validations" do
    new_idea_thread_attr = {user_id: 2, ideas_attributes: [{title: "Get", user_id: 2, idea_thread_id: 4}]}

    new_idea_thread = IdeaThread.new(new_idea_thread_attr)
    new_idea_thread.user_id = nil

    refute new_idea_thread.valid?, "First"

    new_idea_thread = IdeaThread.new(new_idea_thread_attr)

    assert new_idea_thread.valid?, "Second"


  end
end
