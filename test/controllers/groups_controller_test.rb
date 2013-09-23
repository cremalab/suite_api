require 'test_helper'

class GroupsControllerTest < ActionController::TestCase
  test "create" do
    group = {name: "Lords of the Dance"}

    get :create
    assert response :success
  end

  test "show" do
    get :index
    assert_response :success
  end

  test "update" do
    get :update
    assert response :success
  end

  test "destroy" do
    get :destroy
    assert response :success
  end


end
