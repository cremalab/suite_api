require 'test_helper'

class VoteTest < ActiveSupport::TestCase
  def setup
    @user = users(:ross)
    @idea = ideas(:sandwich)
    @idea_thread = IdeaThread.new()
    @idea_thread.voters << @user
    @idea_thread.ideas << @idea
    @idea_thread.status = "open"
    @idea_thread.title = "Sandwich"

    @idea_thread.save

    @new_vote_attr = {user_id: @user.id, idea_id: @idea.id}
  end

  test "email list" do
    vote = votes(:ross_vote_milkshake)
    list = vote.email_list
    assert_equal list, ["ross@poop.com", "michael@theverge.com"]
  end

  test "messages" do
    vote = votes(:ross_vote_milkshake)

    vote.message

    mail = ActionMailer::Base.deliveries.last

    assert_includes mail.body, "Ross Brown"
    assert_includes mail.body, "Milkshakes from Town Topic"
  end


  # test "delete_message" do
  #   #Behavioral Test?

  #   assert false, "I need a test! Waaaaa!"
  # end



  test "voter rights" do
    new_vote = Vote.new(@new_vote_attr)
    @idea_thread.voters.destroy_all
    refute new_vote.valid?
  end


end
