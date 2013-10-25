require 'test_helper'

class ApiKeyTest < ActiveSupport::TestCase
  test "generate_access_token" do
    api_key = ApiKey.create()
    refute_nil api_key.access_token
    assert_equal api_key.access_token.length, 32
  end
end
