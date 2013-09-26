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
    get :show, id: 1
    assert_response :success
  end

  test "update" do
    update_group = groups(:developer_group)
    update_group.name = "King Kong"
    put :update, group: {name: "King Kong"}, id: update_group.id
    assert_response :success
  end

  test "destroy" do
    group = {name: "Lords of the Dance", memberships_attributes: [{user_id: 1}, {user_id: 2}]}
    group = Group.create(group)
    delete :destroy, id: group.id
    assert_response :success
  end


end
