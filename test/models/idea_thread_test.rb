require 'test_helper'

class IdeaThreadTest < ActiveSupport::TestCase
  test "validations" do
    @user = users(:rob)
    new_idea_thread_attr = {
      status: "open",
      title: "Yeah",
      voting_rights_attributes: [{user_id: @user.id}],
      ideas_attributes: [{title: "Get", user_id: @user.id}]
    }

    new_idea_thread = IdeaThread.new(new_idea_thread_attr)
    assert new_idea_thread.valid?, "Second"

    new_idea_thread.voting_rights.destroy_all
    refute new_idea_thread.valid?, "Needs voting_rights_attributes"
  end
end
