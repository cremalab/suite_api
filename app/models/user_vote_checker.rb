# user_vote_checker.rb
# Public:
#
# Example:
class UserVoteChecker

  def create_vote(new_vote)
    if new_vote.save
      #Get existing user votes
      thread = new_vote.idea.idea_thread
      @user  = new_vote.user
      existing_user_vote  = thread.votes.where(user_id: @user.id).where.not(id: new_vote.id)

      if existing_user_vote.count > 0
        first = existing_user_vote.first
        first.create_activity :destroy,
                                      owner: @user,
                                      recipient: first.idea
        if existing_user_vote.destroy_all
          return true
        else
          return false
        end
      else
        return true
      end
    else
      return false
    end
  end

end