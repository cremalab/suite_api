require 'test_helper'
require 'sse'

class SSETest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "initialize and close" do
    response = ActionDispatch::Response.new
    sse = SSE.new(response)
    assert_not_nil sse
    refute sse.io.closed?

    sse.close()
    assert sse.io.closed?

  end

  test "write" do
    response = ActionDispatch::Response.new
    sse = SSE.new(response)

    sse.write("Nanu Nanu")
    assert_equal sse.response.body, "data: \"Nanu Nanu\"\n\n"


    sse.close()


  end

end
