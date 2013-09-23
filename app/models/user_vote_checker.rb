class UserVoteChecker
  def initialize(user, thread)
    @user   = user
    @thread = thread
  end

  def get_existing_user_vote(new_vote)
    vote = @thread.votes.where(user_id: @user.id).where.not(id: new_vote.id).first
    return vote
  end

  def save(new_vote)
    existing_user_vote = get_existing_user_vote(new_vote)

    if new_vote.save
      if existing_user_vote
        if existing_user_vote.destroy
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