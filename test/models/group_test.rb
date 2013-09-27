require 'test_helper'

class GroupTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "validations" do
    #Setup Attributes
    new_group_attr = {name: "Yellow Submarine", owner_id: 1}

    #With all necessary values
    new_group = Group.new(new_group_attr)
    assert new_group.valid?

    #Without Name
    new_group.name = nil
    refute new_group.valid?
    new_group = Group.new(new_group_attr)

    #Without owner_id
    new_group.owner_id = nil
    refute new_group.valid?
  end
end
