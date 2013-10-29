require 'test_helper'

class UserVoteCheckerTest < ActiveSupport::TestCase
  def setup
    Idea.destroy_all
    Vote.destroy_all
    IdeaThread.destroy_all
    @user = users(:ross)
    @idea_thread  = IdeaThread.create(title: 'Lunch')
    @idea_thread.voters << @user
    @idea_thread.save
    @first_idea   = @idea_thread.ideas.create(title: "YJ's", description: "Ravioli today!", user_id: @user.id)
    @second_idea  = @idea_thread.ideas.create(title: "Sylvia's", description: "Chicken Salad Sandwich", user_id: @user.id)
    @first_vote   = Vote.new(idea_id: @first_idea.id, user_id: @user.id)
    @second_vote  = Vote.new(idea_id: @second_idea.id, user_id: @user.id)
  end


  test "should destroy existing vote on new vote" do
    @idea_thread.votes.count.must_equal 0

    checker = UserVoteChecker.new
    checker.create_vote(@first_vote)

    @first_idea.votes.where(user_id: @user.id).length.must_equal 1
    @idea_thread.votes.count.must_equal 1

    checker.create_vote(@second_vote)

    @idea_thread.votes.count.must_equal 1
    @first_idea.votes.where(user_id: @user.id).length.must_equal 0
    @second_idea.votes.where(user_id: @user.id).length.must_equal 1

  end

  def teardown
    @idea_thread.destroy
    @first_idea.destroy
    @second_idea.destroy
  end

end
