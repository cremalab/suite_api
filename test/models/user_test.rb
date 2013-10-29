require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "current_access_token" do
    assert false, "I need a test! Waaaaa!"
  end

  test "display_name" do
    user = users(:rob)
    profile = user.profile
    full_name = "#{profile.first_name} #{profile.last_name}"
    assert_equal user.display_name, full_name
  end

  test "generate_api_key" do
    assert false, "I need a test! Waaaaa!"
  end

  test "message" do
    assert false, "I need a test! Waaaaa!"
  end

  test "subscription" do
    assert false, "I need a test! Waaaaa!"
  end
end
