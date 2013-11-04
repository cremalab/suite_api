# user_vote_checker.rb
# Public:
#
# Example:
class UserVoteChecker

  def create_vote(new_vote)
    if new_vote.save
      #Get existing user votes
      thread = new_vote.idea.idea_thread
      @user = new_vote.user
      votes = thread.votes
      id = @user.id
      existing_user_vote = votes.where(user_id: id).where.not(id: new_vote.id)

      if existing_user_vote.count > 0
        create_activity(existing_user_vote)
        existing_user_vote.destroy_all
      end

      return true
    end

    return false
  end

  def create_activity(existing_user_vote)
    first = existing_user_vote.first
    first.create_activity :destroy, owner: @user,
                                  recipient: first.idea
  end



end