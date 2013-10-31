require 'test_helper'

class Analytics::BaseTest < ActiveSupport::TestCase
  test "self.average" do
    avg = Analytics::Base.average(:idea_thread_creates)

    assert_equal avg, 20

  end

  test "self.var_per_segment" do
    var = Analytics::Base.var_per_segment(:idea_thread_creates)

    assert 1.2, var
  end

  test "self.std_dev_per_segment" do
    std_dev = Analytics::Base.std_dev_per_segment(:idea_thread_creates)

    assert_in_delta 1.09, std_dev, 0.01

  end

end
