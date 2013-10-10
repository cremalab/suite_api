require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  test "index" do
    get :index
    assert_response :success
  end

  test "create" do
    comment_params = {user_id: 1, idea_id: ideas(:mildreds).id, content: "Blue"}
    post :create, comment: comment_params
    assert_response :success

  end

  test "show" do
    assert false, "Hasn't been written"
  end

  test "update" do
    assert false, "Hasn't been written"
  end

  test "destroy" do
    assert false, "Hasn't been written"
  end



end
