require 'test_helper'

class IdeasControllerTest < ActionController::TestCase
  def setup
    @idea = ideas(:sandwich)
    @user = User.create(
      email: 'test@cremalab.com', password: 'password',
      password_confirmation: 'password'
    )
    @user.api_keys.create()
    @request.env["HTTP_X_REQUESTED_WITH"] = {}
    @request.env["HTTP_X_USER_ID"] = @user.id
    @request.env["HTTP_X_ACCESS_TOKEN"] = @user.current_access_token
  end

  test "create" do

    @user = users(:rob)
    @idea_thread = idea_threads(:lunch)
    @idea_thread.voters << @user

    meatloaf = {title: "Meatloaf at YJ's",
                description: "Mmmmm... eatloaf", user_id: @user.id,
                idea_thread_id: @idea_thread.id}
    idea_count = Idea.all.count
    post :create, idea: meatloaf
    assert_response :success
    assert_includes @response.body, "id"
    assert_includes @response.body, "title"
    assert_includes @response.body, "description"
    assert_includes @response.body, "idea_thread_id"
    assert_includes @response.body, "user_id"
    assert_includes @response.body, "updated_at"
    assert_includes @response.body, "created_at"
    assert_includes @response.body, "total_votes"
    assert_includes @response.body, "user"
    assert_includes @response.body, "id"
    assert_includes @response.body, "profile"
    assert_includes @response.body, "first_name"
    assert_includes @response.body, "last_name"
    assert_includes @response.body, "votes"
    assert_includes @response.body, "model_name"

    assert_equal Idea.last.related_activities.count, 1
    assert_includes Idea.last.related_activities.last.key, "idea.create"

    Idea.all.count.must_equal idea_count + 1
  end

  test "create failure" do
    @user = users(:michael)
    @idea_thread = idea_threads(:lunch)
    meatloaf = {title: "Meatloaf at YJ's",
                description: "Mmmmm... eatloaf", user_id: @user.id,
                idea_thread_id: @idea_thread.id}
    post :create, idea: meatloaf
    assert_response 422
    assert_includes @response.body, "You do not have permission to add an idea to this thread"
  end

  test "show" do
    get :show, id: @idea.id
    assert_response :success
    assert_includes @response.body, "Chicken Salad Sandwiches at Sylvias"
    assert_includes @response.body, "It's the best sandwich they have"
  end

  test "update" do

    put :update, id: @idea.id, idea: {title: "BLT at Mildreds"}, auth: @auth
    assert_response :success
    assert_includes @response.body, "BLT at Mildreds"
    idea = Idea.find(@idea.id)
    idea.title.must_equal "BLT at Mildreds"

    assert_equal idea.related_activities.count, 1
    assert_includes idea.related_activities.last.key, "idea.update"
  end

  test "update failure" do
    put :update, id: @idea.id, idea: {title: nil}, auth: @auth

    assert_response 422

  end

  test "destroy" do
    idea_count = Idea.all.count
    delete :destroy, id: @idea.id
    assert_response :success
    Idea.all.count.must_equal idea_count - 1
  end

  test "should return unauthorized if no access_token" do
    @request.env["HTTP_X_ACCESS_TOKEN"] = ''
    get :show, id: @idea.id, auth: {}
    assert_response :unauthorized
  end

  def teardown
    @idea.destroy
    @user.destroy
    @auth = nil
  end

end
