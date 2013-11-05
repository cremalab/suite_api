require 'test_helper'

class IdeaThreadsControllerTest < ActionController::TestCase
  def setup
    @user = User.create(
      email: 'test@cremalab.com', password: 'password',
      password_confirmation: 'password', profile_attributes:
        {first_name: 'Fred', last_name: 'Flintstone'}
    )
    NotificationSetting.create(idea_thread: true, user_id: @user.id)
    @user.api_keys.create()
    @request.env["HTTP_X_REQUESTED_WITH"] = {}
    @request.env["HTTP_X_USER_ID"] = @user.id
    @request.env["HTTP_X_ACCESS_TOKEN"] = @user.current_access_token
  end

  test "index" do
    get :index
    assert_response :success
    #assert_includes @response.body, "ideas"
  end

  test "create" do
    meatloaf = {title: "Meatloaf at YJs",
                description: "Mmmmm... eatloaf", user_id: @user.id}
    voting_rights = {user_id: @user.id}
    params = {  title: "Lunch", status: "open", user_id:  @user.id,
                expiration: "2014-02-11 11:25:00",
                ideas_attributes: [meatloaf],
                voting_rights_attributes: [voting_rights]  }
    idea_thread_count = IdeaThread.all.count
    voting_rights_count = VotingRight.all.count

    post :create, idea_thread: params
    assert_response :success

    IdeaThread.all.count.must_equal idea_thread_count + 1
    VotingRight.all.count.must_equal voting_rights_count + 1
    IdeaThread.last.voters.count.must_equal 1
    IdeaThread.last.related_activities.last.key.must_equal 'idea_thread.create'

    assert_includes @response.body, "id"
    assert_includes @response.body, "title"
    assert_includes @response.body, "created_at"
    assert_includes @response.body, "updated_at"
    assert_includes @response.body, "user_id"
    assert_includes @response.body, "status"
    assert_includes @response.body, "description"
    assert_includes @response.body, "expiration"
    assert_includes @response.body, "original_idea_id"
    assert_includes @response.body, "ideas"
    assert_includes @response.body, "model_name"
    assert_includes @response.body, "voting_rights"

  end

  test "create failure" do
    assert_response 422
  end

  test "show" do
    assert_response :success
  end

  test "update" do
    assert_response :success
  end

  test "update failure" do
    assert_response 422
  end

  test "destroy" do
    meatloaf = {title: "Meatloaf at YJs",
                description: "Mmmmm... eatloaf",
                user_id: 1
              }
    params = {title: "Lunch", user_id: 1, status: "open",
                expiration: "2014-02-11 11:25:00",
                ideas_attributes: [meatloaf],
                voting_rights_attributes: [{user_id: 1}] }
    thread = IdeaThread.create(params)
    IdeaThread.delay(run_at: thread.expiration, queue: thread.id).set_archive(thread.id)
    delete :destroy, id: thread.id
    assert_response :success
    assert_includes @response.body, "Idea thread destroyed"
  end

end
