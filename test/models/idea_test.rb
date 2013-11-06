require 'test_helper'

class IdeaTest < ActiveSupport::TestCase
  def setup
    @user = users(:rob)
    @idea_thread = IdeaThread.new()
    @idea_thread.voters << @user
    @idea_thread.status = "open"
    @idea_thread.title = "Sandwich"
    @idea_thread.save

    @new_idea_attr = {title: "Meatloaf at YJ's",
                      idea_thread_id: @idea_thread.id,
                      description: "Mmmmm... eatloaf", user_id: @user.id,
                    }


  end


  test "create_associated_vote" do
    idea = Idea.create(@new_idea_attr)
    #Check for associated vote
    idea.create_associated_vote
    assert_equal idea.votes.length, 1
  end

  # test "delete_message" do
  #   #Don't know how to test this yet.
  #   assert false, "I need a test! Waaaaa!"
  # end


  test "email list" do
    idea = ideas(:milkshakes)
    list = idea.email_list

    assert_equal list, ["ross@poop.com", "michael@theverge.com"]
  end

  test "first_in_thread?" do
    idea_thread = idea_threads(:lunch)

    refute idea_thread.ideas[0].first_in_thread?
    assert idea_thread.ideas[1].first_in_thread?
  end

  test "message" do
    idea = ideas(:milkshakes)

    idea.message

    mail = ActionMailer::Base.deliveries.last

    assert_includes mail.body, "Milkshakes from Town Topic"
    assert_includes mail.body, "Fun"
  end

  test "num_votes" do
    idea = ideas(:milkshakes)

    assert_equal idea.num_votes, 2


  end

  test "recent_activities" do
    idea = ideas(:milkshakes)
    for i in 0..12
      idea.create_activity :create, owner: idea.user
    end
    assert_equal idea.recent_activities.length, 10
  end

  test "related activities" do
    idea = Idea.create(@new_idea_attr)
    idea.create_activity :create, owner: @user

    idea.related_activities.count.must_equal 1
    @idea_thread.related_activities.count.must_equal 1
  end

  test "voting rights" do
    @idea_thread.voters.destroy_all
    new_idea = Idea.new(@new_idea_attr)
    refute new_idea.valid?
  end

end
