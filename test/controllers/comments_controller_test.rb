require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  def setup
    @idea_id = ideas(:mildreds).id
    comment_params = {user_id: 1, idea_id: @idea_id, content: "Yellow"}
    @comment = Comment.create(comment_params)
  end

  test "create" do
    comment_params = {user_id: 1, idea_id: @idea_id, content: "Blue"}
    post :create, comment: comment_params, idea_id: @idea_id
    assert_response :success
    assert_equal @comment.idea.related_activities.count, 1
    assert_includes @comment.idea.related_activities.last.key, "comment.create"
  end

  test "create_fail" do
    comment_params = {user_id: 1, idea_id: @idea_id}
    post :create, comment: comment_params, idea_id: @idea_id
    assert_response 422
  end

  test "show" do
    get :show, id: @comment.id
    assert_response :success
  end

  test "update" do
    post :update, id: @comment.id, comment: {content: "Red"}
    assert_response :success
    assert_includes @response.body, "Red"
    Comment.find(@comment.id).content.must_equal "Red"
  end

  test "update_fail" do
    post :update, id: @comment.id, comment: {content: nil}
    assert_response 422

  end

  test "destroy" do
    comment_params = {user_id: 1, idea_id: ideas(:mildreds).id, content: "Blue"}
    comment = Comment.create(comment_params)
    delete :destroy, id: comment.id
    assert_response :success
    assert_includes @response.body, "Comment destroyed"
  end

end
