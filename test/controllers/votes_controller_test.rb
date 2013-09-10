require 'test_helper'

class VotesControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @vote = votes(:ross_vote_milkshake)
    @user = User.create(
      email: 'test@cremalab.com', password: 'password',
      password_confirmation: 'password'
    )
    @vote.user_id = @user.id
    @user.api_keys.create()
    @request.env["HTTP_X_REQUESTED_WITH"] = {}
    @request.env["HTTP_X_USER_ID"] = @user.id
    @request.env["HTTP_X_ACCESS_TOKEN"] = @user.current_access_token
    @idea = ideas(:sandwich)
    @idea.idea_thread.voters << @user
  end

  test "create" do
    new_vote = {user_id: @user.id, idea_id: @idea.id}
    vote_count = Vote.all.count
    post :create, vote: new_vote
    assert_response :success
    Vote.all.count.must_equal vote_count + 1
  end

  test "can't create without permission" do
    new_vote = {user_id: @user.id, idea_id: @idea.id}
    @idea.idea_thread.voters.destroy_all
    vote_count = Vote.all.count
    post :create, vote: new_vote
    assert_response :unprocessable_entity
    Vote.all.count.must_equal vote_count
  end

  test "show" do
    get :show, id: @vote.id
    assert_response :success

  end

  test "destroy" do
    vote_count = Vote.all.count
    delete :destroy, id: @vote.id
    assert_response :success
    Vote.all.count.must_equal vote_count - 1

  end

  def teardown
    @user.destroy
    @vote.destroy
  end
end
