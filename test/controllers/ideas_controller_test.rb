require 'test_helper'

class IdeasControllerTest < ActionController::TestCase
  def setup
    @idea = Idea.create(sandwiches)
  end

  test "should create new idea" do
    idea_count = Idea.all.count
    post :create, idea: milkshakes
    assert_response :success
    assert_includes @response.body, "id"
    assert_includes @response.body, "title"
    assert_includes @response.body, "description"
    assert_includes @response.body, "when"
    assert_includes @response.body, "idea_votes"
    Idea.all.count.must_equal idea_count + 1
  end

  test "should get show" do
    get :show, id: @idea.id
    assert_response :success
    assert_includes @response.body, "Chicken Salad Sandwiches at Sylvia's"
    assert_includes @response.body, "It's the best sandwich they have"
  end

  test "should get update" do
    put :update, id: @idea.id, idea: {title: "BLT at Mildred's"}
    assert_response :success
    assert_includes @response.body, "BLT at Mildred's"
    Idea.find(@idea.id).title.must_equal "BLT at Mildred's"
  end

  test "should get destroy" do
    idea_count = Idea.all.count
    delete :destroy, id: milkshakes.id
    assert_response :success
    Idea.all.count.must_equal idea_count - 1
  end

  def teardown
    @idea.destroy
  end

end
