require 'test_helper'

class GroupsControllerTest < ActionController::TestCase
  def setup
    @user = User.create(
      email: 'test@cremalab.com', password: 'password',
      password_confirmation: 'password', profile_attributes:
        {first_name: 'Fred', last_name: 'Flintstone'}
    )
    @user.api_keys.create()
    @request.env["HTTP_X_REQUESTED_WITH"] = {}
    @request.env["HTTP_X_USER_ID"] = @user.id
    @request.env["HTTP_X_ACCESS_TOKEN"] = @user.current_access_token
    Group.create(owner: @user, name: "Mellow Yellow")
  end
  test "index" do
    get :index
    assert_response :success
    assert_includes @response.body, "id"
    assert_includes @response.body, "name"
    assert_includes @response.body, "created_at"
    assert_includes @response.body, "updated_at"
    assert_includes @response.body, "owner_id"
    assert_includes @response.body, "membership"
  end

  test "create" do
    group = {name: "Lords of the Dance", owner_id: 1, memberships_attributes: [{user_id: 1}, {user_id: 2}]}
    post :create, group: group

    assert_response :success
    assert_includes @response.body, "name"
    assert_includes @response.body, "id"

  end

  test "show" do
    get :show, id: 1

    assert_response :success
    assert_includes @response.body, "name"

  end

  test "update" do
    update_group = groups(:developer_group)
    update_group.name = "King Kong"
    put :update, group: {name: "King Kong"}, id: update_group.id
    assert_response :success
  end

  test "destroy" do
    group = {name: "Lords of the Dance", owner_id: 1, memberships_attributes: [{user_id: 1}, {user_id: 2}]}
    group = Group.create(group)
    group_count = Group.all.count

    delete :destroy, id: group.id
    assert_response :success
    Group.all.count.must_equal group_count - 1

  end


end
