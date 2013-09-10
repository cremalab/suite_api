require 'test_helper'

class VotingRightsControllerTest < ActionController::TestCase
  test "should get destroy" do
    get :destroy
    assert_response :success
  end

  test "should get show" do
    get :show
    assert_response :success
  end

end
