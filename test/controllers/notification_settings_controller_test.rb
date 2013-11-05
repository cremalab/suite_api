require 'test_helper'

class NotificationSettingsControllerTest < ActionController::TestCase
  def setup
    @notification_setting = notification_settings(:one)
  end

  test "update" do
    post :update, id: @notification_setting.id,
                  notification_settings: {sound: 0}
    assert_response :success
    assert_includes @response.body, "vote"
    assert_includes @response.body, "false"

  end

  test "update failure" do
    post :update, id: @notification_setting.id,
          notification_settings: {vote: nil}

    assert_response 422
  end

end
