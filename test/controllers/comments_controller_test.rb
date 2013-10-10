require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  def setup
    @idea_id = ideas(:mildreds).id
    comment_params = {user_id: 1, idea_id: @idea_id, content: "Yellow"}
    @comment = Comment.create(comment_params)
  end

  test "index" do
    get :index
    assert_response :success
  end

  test "create" do
    comment_params = {user_id: 1, idea_id: @idea_id, content: "Blue"}
    post :create, comment: comment_params
    assert_response :success

  end

  test "show" do
    get :show, id: @comment.id
    assert_response :success
  end

  test "update" do
    assert false, "Hasn't been written"
  end

  test "destroy" do
    comment_params = {user_id: 1, idea_id: ideas(:mildreds).id, content: "Blue"}
    comment = Comment.create(comment_params)
    delete :destroy, id: comment.id
    assert_response :success
    assert_includes @response.body, "Comment destroyed"
  end



end
