require 'test_helper'

class GroupsControllerTest < ActionController::TestCase
  test "index" do
    get :index
    assert_response :success


  end

  test "create" do
    group = {name: "Lords of the Dance", memberships_attributes: [{user_id: 1}, {user_id: 2}]}
    post :create, group: group
    assert_response :success
  end

  test "show" do
    get :show
    assert_response :success
  end

  test "update" do
    put :update
    assert response :success
  end

  test "destroy" do
    get :destroy
    assert response :success
  end


end
