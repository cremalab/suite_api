require 'test_helper'

class IdeaThreadsControllerTest < ActionController::TestCase
  def setup
    @user = User.create(
      email: 'test@cremalab.com', password: 'password',
      password_confirmation: 'password', profile_attributes:
        {first_name: 'Fred', last_name: 'Flintstone'}
    )
    @user.api_keys.create()
    @request.env["HTTP_X_REQUESTED_WITH"] = {}
    @request.env["HTTP_X_USER_ID"] = @user.id
    @request.env["HTTP_X_ACCESS_TOKEN"] = @user.current_access_token
  end

  test "should get index" do
    get :index
    assert_response :success
    # assert_includes @response.body, "ideas"
  end

  test "should post create" do
    meatloaf = {title: "Meatloaf at YJs", when: "2013-08-28 09:26:06 -0500",
                description: "Mmmmm... eatloaf", user_id: @user.id}
    voting_rights = {user_id: @user.id}
    params = { title: "Lunch", status: "open", ideas_attributes: [meatloaf], voting_rights_attributes: [voting_rights] }
    idea_thread_count = IdeaThread.all.count
    voting_rights_count = VotingRight.all.count

    post :create, idea_thread: params
    assert_response :success

    IdeaThread.all.count.must_equal idea_thread_count + 1
    VotingRight.all.count.must_equal voting_rights_count + 1
    IdeaThread.last.voters.count.must_equal 1

    assert_includes @response.body, "Meatloaf"
    assert_includes @response.body, "created_at"
  end

  test "should destroy" do
    meatloaf = {title: "Meatloaf at YJs", when: "2013-08-28 09:26:06 -0500",
                description: "Mmmmm... eatloaf", user_id: 1
              }
    params = {title: "Lunch", user_id: 1, status: "open", ideas_attributes: [meatloaf], voting_rights_attributes: [{user_id: 1}] }
    thread = IdeaThread.create(params)
    delete :destroy, id: thread.id
    assert_response :success
    assert_includes @response.body, "Idea thread destroyed"
  end

end
