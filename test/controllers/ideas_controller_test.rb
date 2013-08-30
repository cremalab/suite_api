require 'test_helper'

class IdeasControllerTest < ActionController::TestCase
  def setup
    @idea = ideas(:sandwich)
    @user = User.create(
      email: 'test@cremalab.com', password: 'password',
      password_confirmation: 'password'
    )
    @user.api_keys.create()
    @request.env["HTTP_X_USER_ID"] = @user.id
    @request.env["HTTP_X_ACCESS_TOKEN"] = @user.current_access_token
  end

  test "should create new idea" do
    meatloaf = {title: "Meatloaf at YJs", when: "2013-08-28 09:26:06 -0500",
                description: "Mmmmm... eatloaf", user_id: 1}
    idea_count = Idea.all.count
    post :create, idea: meatloaf, auth: @auth
    assert_response :success
    assert_includes @response.body, "id"
    assert_includes @response.body, "title"
    assert_includes @response.body, "description"
    assert_includes @response.body, "when"
    Idea.all.count.must_equal idea_count + 1
  end

  test "should get show" do
    get :show, id: @idea.id, auth: @auth
    assert_response :success
    assert_includes @response.body, "Chicken Salad Sandwiches at Sylvia's"
    assert_includes @response.body, "It's the best sandwich they have"
  end

  test "should get update" do
    put :update, id: @idea.id, idea: {title: "BLT at Mildred's"}, auth: @auth
    assert_response :success
    assert_includes @response.body, "BLT at Mildred's"
    Idea.find(@idea.id).title.must_equal "BLT at Mildred's"
  end

  test "should get destroy" do
    idea_count = Idea.all.count
    delete :destroy, id: @idea.id, auth: @auth
    assert_response :success
    Idea.all.count.must_equal idea_count - 1
  end

  test "should return unauthorized if no access_token" do
    @request.env["HTTP_X_ACCESS_TOKEN"] = 'ta-daaaaaa'
    p @request.env["HTTP_X_ACCESS_TOKEN"]
    get :show, id: @idea.id, auth: {}
    assert_response :unauthorized
  end

  def teardown
    @idea.destroy
    @user.destroy
    @auth = nil
  end

end
