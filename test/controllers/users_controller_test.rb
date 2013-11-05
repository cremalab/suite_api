require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  test "index" do
    assert_response :success
  end

  test "create" do
    new_user = {user: {email: "mattowens11@gmail.com", password: "yellowsub",
                password_confirmation: "yellowsub"} }
    post :create, new_user
    user = User.find_by(email: "mattowens11@gmail.com")
    assert_not_nil user
    assert_not_nil user.profile

    # Has API key with access token
    assert_not_nil user.api_keys.first
    assert_not_nil user.api_keys.first.access_token
    assert_response :success
    assert_includes @response.body, "id"
    assert_includes @response.body, "name"
    assert_includes @response.body, "notifications"
    assert_includes @response.body, "\"logged_in\":true"
    assert_includes @response.body, "access_token"
    assert_includes @response.body, "user_id"
    assert_includes @response.body, "access_token"
  end

  test "create failure" do
    post :create, user:
      {
        email: "mattowens11@gmail.com"
      }
    assert_response 422
    assert_nil User.find_by(email: "mattowens11@gmail.com")
    assert_includes @response.body, "can't be blank"
  end

  test "show" do
    new_user = {email: "mattowens11@gmail.com", password: "yellowsub",
                password_confirmation: "yellowsub", profile_attributes: {
                  first_name: "Matt", last_name: "Owens" }
                }
    user = User.create(new_user)
    api_key = user.api_keys.create()
    user_id = user.id

    @request.env["HTTP_X_USER_ID"] = user_id
    @request.env["HTTP_X_ACCESS_TOKEN"] = user.current_access_token

    get :show, id: user_id
    assert_response :success
    assert_includes @response.body, "mattowens11@gmail.com"
  end

  test "update" do
    assert_response :success
  end

  test "update failure" do
    assert_response 422
  end


  test "me" do
    assert_response :success
  end

  test "me failure" do

  end

end
