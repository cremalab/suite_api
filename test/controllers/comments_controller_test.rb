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

    assert_includes @response.body, "id"
    assert_includes @response.body, "content"
    assert_includes @response.body, "created_at"
    assert_includes @response.body, "updated_at"
    assert_includes @response.body, "user_id"
    assert_includes @response.body, "idea_id"
    assert_includes @response.body, "user_name"
    assert_includes @response.body, "model_name"

  end

  test "create" do
    comment_params = {user_id: 1, idea_id: @idea_id, content: "Blue"}
    post :create, comment: comment_params, idea_id: @idea_id
    assert_response :success
    assert_equal @comment.idea.related_activities.count, 1
    assert_includes @comment.idea.related_activities.last.key, "comment.create"
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

  test "destroy" do
    comment_params = {user_id: 1, idea_id: ideas(:mildreds).id, content: "Blue"}
    comment = Comment.create(comment_params)
    delete :destroy, id: comment.id
    assert_response :success
    assert_includes @response.body, "Comment destroyed"
  end



end
