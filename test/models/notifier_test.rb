require 'test_helper'
require 'notifier'

class NotifierTest < ActiveSupport::TestCase

  test "idea init" do
    idea = ideas(:milkshakes)
    name = Notifier.new(idea, "Idea")
    pp name.payload


  end

  test "idea thread init" do
    idea_thread = idea_threads(:fun)
    name = Notifier.new(idea_thread, "IdeaThread")
    pp name.payload


  end

  test "user init" do
    user = users(:ross)
    name = Notifier.new(user, "User")
    pp name.payload


  end

  test "vote init" do
    vote = votes(:ross_vote_milkshake)
    name = Notifier.new(vote, "Vote")
    pp name.payload


  end

end