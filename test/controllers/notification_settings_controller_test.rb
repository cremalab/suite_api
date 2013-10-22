require 'test_helper'

class NotificationSettingsControllerTest < ActionController::TestCase
  def setup
    @notification_setting = notification_settings(:one)
  end

  test "update" do
    post :update, id: @notification_setting.id,
                  notification_settings: {vote: false}
    assert_response :success
    assert_includes @response.body, "vote"
    assert_includes @response.body, "false"





  end
end
