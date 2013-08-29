require 'test_helper'

class IdeaVoteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "validation" do
    new_vote_attr = {user_id: 1, idea_id: 2, vote: "Yes"}

    new_vote = Vote.new(new_vote_attr)
    new_vote.user_id = nil
    refute new_vote.valid?

    new_vote = Vote.new(new_vote_attr)
    new_vote.idea_id = nil
    refute new_vote.valid?

    new_vote = Vote.new(new_vote_attr)
    new_vote.vote = nil
    refute new_vote.valid?

    new_vote = Vote.new(new_vote_attr)
    assert new_vote.valid?



  end

end
