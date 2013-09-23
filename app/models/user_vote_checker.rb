class UserVoteChecker
  def initialize(user, thread)
    @user   = user
    @thread = thread
  end

  def get_existing_user_votes(new_vote)
    votes = @thread.votes.where(user_id: @user.id).where.not(id: new_vote.id)
    return votes
  end

  def save(new_vote)
    if new_vote.save
      existing_user_vote = get_existing_user_votes(new_vote)
      if existing_user_vote.count > 0
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