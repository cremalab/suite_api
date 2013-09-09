require 'test_helper'
require 'listener'

class ListenerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "initialize" do
    listener = Listener.new

    #listener.listen()

    listener.close()

  end
end
