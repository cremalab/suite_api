require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "Create New" do
    new_user = {email: "mattowens11@gmail.com", password: "yellowsub",
                password_confirmation: "yellowsub" }
    post :create, user: new_user
    assert_not_nil User.find_by(email: "mattowens11@gmail.com")
    assert_response :success
  end

  test "Log in after sign up" do
    new_user = {email: "mattowens11@gmail.com", password: "yellowsub",
                password_confirmation: "yellowsub" }
    post :create, user: new_user
    assert_response :success
    response = JSON.parse(@response.body)
    assert_equal response['logged_in'], true
  end

  test "should return error if validation fails" do
    post :create, user:
      {
        email: "mattowens11@gmail.com"
      }
    assert_response :unprocessable_entity
    assert_nil User.find_by(email: "mattowens11@gmail.com")
    assert_includes @response.body, "can't be blank"
  end

  test "should get show" do
    new_user = {email: "mattowens11@gmail.com", password: "yellowsub",
                password_confirmation: "yellowsub" }
    user = User.create(new_user)
    user_id = user.id
    get :show, id: user_id
    assert_response :success
    assert_includes @response.body, "mattowens11@gmail.com"
  end

end
