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
end
