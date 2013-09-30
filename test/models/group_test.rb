require 'test_helper'

class GroupTest < ActiveSupport::TestCase

  def setup
    @new_group_attr = {name: "Yellow Submarine", owner_id: 1}
  end

  test "validations" do
    #With all necessary values
    new_group = Group.new(@new_group_attr)
    assert new_group.valid?
  end

  test "presence of name" do
    new_group = Group.new(@new_group_attr)
    new_group.name = nil
    refute new_group.valid?
  end

  test "presence of owner id" do
    new_group = Group.new(@new_group_attr)
    new_group.owner_id = nil
    refute new_group.valid?
  end
end
