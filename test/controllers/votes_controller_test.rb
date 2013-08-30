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
    @user.api_keys.create()
    @request.env["HTTP_X_USER_ID"] = @user.id
    @request.env["HTTP_X_ACCESS_TOKEN"] = @user.current_access_token
    @idea = ideas(:sandwich)


  end

  test "create" do
    new_vote = {user_id: @user.id, idea_id: @idea.id}
    vote_count = Vote.all.count
    post :create, vote: new_vote
    assert_response :success
    Vote.all.count.must_equal vote_count + 1
  end

  test "show" do
    get :show, id: @vote.id
    assert_response :success
<<<<<<< HEAD

  end

  # test "update" do
  #   get :update, id: @vote.id, auth: @auth
  #   assert_response :success
=======
    p @response.body
    # assert_includes @response.body, "Yes"

  end

  test "update" do
    new_vote = {vote: "No"}
    get :update, id: @vote.id, vote: new_vote
    assert_response :success
    # assert_includes @response.body, "No"
>>>>>>> ab389f648957baaf7c33304b94637032c0ad62a0

  # end

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
