require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "login" do
    post :create, email: 'ross@poop.com', password: 'poopmom'
    assert_response :success
    assert_includes @response.body, "ross@poop.com"
  end

  test "logout" do
    get :destroy
    assert_response :success
    assert_includes @response.body, "Logged out"

  end
end
