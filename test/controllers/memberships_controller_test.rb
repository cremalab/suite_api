require 'test_helper'

class MembershipsControllerTest < ActionController::TestCase
  def setup
    @owner = users(:rob)
    @owner.api_keys.create()


    @member = users(:ross)
    @group  = Group.create(name: "Smart Voters", owner_id: @owner.id)

    @group.users << @member
    @membership = @group.memberships.first
  end

  test "destroy" do
    # As Group Owner
    @request.env["HTTP_X_REQUESTED_WITH"] = {}
    @request.env["HTTP_X_USER_ID"] = @owner.id
    @request.env["HTTP_X_ACCESS_TOKEN"] = @owner.current_access_token

    assert_equal(@group.memberships.count, 1)
    delete :destroy, id: @membership.id
    assert_response :success
    assert_equal(@group.memberships.count, 0)
    assert_empty Membership.where(id: @membership.id)
  end

  test "destroy failure" do
    assert_response 422
  end

  test "should only respond to group owner" do
    # As Sombody else
    @request.env["HTTP_X_REQUESTED_WITH"] = {}
    @request.env["HTTP_X_USER_ID"] = @member.id
    @request.env["HTTP_X_ACCESS_TOKEN"] = @member.current_access_token

    assert_equal(@group.memberships.count, 1)
    delete :destroy, id: @membership.id
    assert_response 401
    assert_equal(@group.memberships.count, 1)
    refute_empty Membership.where(id: @membership.id)
  end

end
