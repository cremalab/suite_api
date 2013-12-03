require 'test_helper'

class Analytics::BaseTest < ActiveSupport::TestCase
  test "self.average_per_segment" do
    avg = Analytics::Base.average_per_segment(:idea_thread_creates)

    assert_equal avg, 20

  end

  test "self.var_per_segment" do
    var = Analytics::Base.var_per_segment(:idea_thread_creates)

    assert_equal 1.2, var
  end

  test "self.std_dev_per_segment" do
    std_dev = Analytics::Base.std_dev_per_segment(:idea_thread_creates)

    assert_in_delta 1.09, std_dev, 0.01

  end

  test "self.average_per_segment with time" do
    avg = Analytics::Base.average_per_segment(:idea_thread_creates,
                                              "2013-10-31 16:00",
                                              "2013-10-31 16:05")

    assert_equal avg, 20

  end

  test "self.var_per_segment with time" do
    var = Analytics::Base.var_per_segment(:idea_thread_creates,
                                          "2013-10-31 16:00",
                                          "2013-10-31 16:05")
    assert_equal 0.1, var

  end

  test "self.std_dev_per_segment with time" do
    std_dev = Analytics::Base.std_dev_per_segment(:idea_thread_creates,
                                                  "2013-10-31 16:00",
                                                  "2013-10-31 16:05")

    assert_in_delta 0.31, std_dev, 0.01

  end

end
