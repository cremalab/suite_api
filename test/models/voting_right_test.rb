require 'test_helper'

class VotingRightTest < ActiveSupport::TestCase
  test "destroy_associtated_votes" do
    voting_right = voting_rights(:rob)
    idea_thread = idea_threads(:fun)
    assert_equal idea_thread.votes.length, 2
    voting_right.destroy_associtated_votes
    idea_thread = IdeaThread.find(idea_thread.id)
    assert_equal idea_thread.votes.length, 1

  end

end
