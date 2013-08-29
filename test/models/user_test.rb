require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "confirm Password" do
    new_user_attr = {email: "mattowens11@gmail.com", password: "fauxhawks"}

    #nil
    new_user_attr[:password_confirmation] = nil
    new_user = User.new(new_user_attr)
    refute new_user.valid?



    #Mismatch
    new_user_attr[:password_confirmation] = "mowhawks"
    new_user = User.new(new_user_attr)

    refute new_user.valid?

    #Match
    new_user_attr[:password_confirmation] = "fauxhawks"
    new_user = User.new(new_user_attr)
    assert new_user.valid?

    #Make sure you can still update with out password confirmation
    assert users(:ross).update(email: "poop@poop.com" )


  end

  test "presence of email" do
    new_user_attr = {password: "fauxhawks",
                      password_confirmation: "fauxhawks"}

    new_user = User.new(new_user_attr)
    refute new_user.valid?

    new_user_attr[:email] = "mattowens11@gmail.com"
    new_user = User.new(new_user_attr)
    assert new_user.valid?

  end

  test "uniqueness of email" do
    new_user = users(:ross).attributes
    new_user = User.new(new_user)
    refute new_user.valid?
  end
end
