require 'test_helper'

class VoteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "validation" do
    @user = users(:ross)
    @idea = ideas(:sandwich)
    @idea_thread = IdeaThread.new()
    @idea_thread.voters << @user
    @idea_thread.ideas << @idea
    @idea_thread.status = "open"
    @idea_thread.save

    new_vote_attr = {user_id: @user.id, idea_id: @idea.id}

    new_vote = Vote.new(new_vote_attr)

    new_vote.user_id = nil
    refute new_vote.valid?

    new_vote = Vote.new(new_vote_attr)
    new_vote.idea_id = nil
    refute new_vote.valid?

    new_vote = Vote.new(new_vote_attr)
    assert new_vote.valid?

    new_vote = Vote.new(new_vote_attr)
    @idea_thread.voters.destroy_all
    refute new_vote.valid?

  end

end
