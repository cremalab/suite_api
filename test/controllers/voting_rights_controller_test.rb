###############################################################################
require 'test_helper'

class VotingRightsControllerTest < ActionController::TestCase

  test "create" do
    assert_response :success
  end

  test "create failure" do
    assert_response 422
  end

  test "show" do
    assert_response :success
  end


  test "destroy" do
    # Create an idea thread
    idea_thread = IdeaThread.create({ title: "Who is the best?",
                                      user_id: 1,
                                      status: "open",
                                      voting_rights_attributes: [
                                        {user_id: 1},
                                        {user_id: 2}],
                                      ideas_attributes: [
                                        {title: "Rob", user_id: 1,
                                        votes_attributes:[
                                          {user_id: 1},
                                          {user_id: 2}]}
                                        ]})


    vote_size = idea_thread.ideas[0].votes.length
    original_size = idea_thread.voting_rights.length


    # Delete the voting right
    delete :destroy, id: idea_thread.voting_rights[1].id
    assert_response :success

    voting_rights = VotingRight.where(idea_thread_id: idea_thread.id)
    # Make sure voting right is gone
    voting_rights.size.must_equal original_size - 1

    # Make sure the vote is gone
    votes = Vote.where(idea_id: idea_thread.ideas[0].id)

    votes.length.must_equal vote_size - 1
  end

  test "destroy failure" do
    assert_response 422
  end

end
