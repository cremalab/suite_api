require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "current_access_token" do
    user = users(:rob)
    assert_equal user.api_keys.length, 0
    user.generate_api_key
    assert_equal user.current_access_token.length, 32
  end

  test "display_name" do
    user = users(:rob)
    profile = user.profile
    full_name = "#{profile.first_name} #{profile.last_name}"
    assert_equal user.display_name, full_name
  end

  test "generate_api_key" do
    user = users(:rob)
    assert_equal user.api_keys.length, 0
    user.generate_api_key
    assert_equal user.api_keys.length, 1
  end

  # test "message" do
  #   assert false, "I need a test! Waaaaa!"
  # end

  test "subscription" do
    user = users(:rob)
    subscription = user.subscription
    assert_equal subscription[:server],     "http://localhost:9292/faye"
    assert_equal subscription[:channel],    "/message/channel"
    assert_not_nil subscription[:signature]


  end
end
