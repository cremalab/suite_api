require 'test_helper'

class VoteTest < ActiveSupport::TestCase
  def setup
    @user = users(:ross)
    @idea = ideas(:sandwich)
    @idea_thread = IdeaThread.new()
    @idea_thread.voters << @user
    @idea_thread.ideas << @idea
    @idea_thread.status = "open"
    @idea_thread.title = "Sandwich"

    @idea_thread.save

    @new_vote_attr = {user_id: @user.id, idea_id: @idea.id}

  end

  test "validation" do
    #With all necessary values
    new_vote = Vote.new(@new_vote_attr)
    assert new_vote.valid?
  end

  test "presence of user id" do
    new_vote = Vote.new(@new_vote_attr)
    new_vote.user_id = nil
    refute new_vote.valid?
  end

  test "presence of idea id" do
    new_vote = Vote.new(@new_vote_attr)
    new_vote.idea_id = nil
    refute new_vote.valid?
  end

  test "voter rights" do
    new_vote = Vote.new(@new_vote_attr)
    @idea_thread.voters.destroy_all
    refute new_vote.valid?
  end

  test "email list" do
    vote = votes(:ross_vote_milkshake)
    list = vote.email_list
    assert_equal list, ["ross@poop.com", "michael@theverge.com"]
  end
end
