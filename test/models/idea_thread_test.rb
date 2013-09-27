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
end
