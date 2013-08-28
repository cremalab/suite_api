require 'test_helper'

class IdeaVoteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "validation" do
    new_idea_vote_attr = {user_id: 1, idea_id: 2}

    new_idea_vote = IdeaVote.new(new_idea_vote_attr)
    new_idea_vote.user_id = nil
    refute new_idea_vote.valid?

    new_idea_vote = IdeaVote.new(new_idea_vote_attr)
    new_idea_vote.idea_id = nil
    refute new_idea_vote.valid?

    new_idea_vote = IdeaVote.new(new_idea_vote_attr)
    assert new_idea_vote.valid?



  end

end
