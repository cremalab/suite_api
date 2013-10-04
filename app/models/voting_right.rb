class VotingRight < ActiveRecord::Base
  #Relationships
  belongs_to :idea_thread
  belongs_to :voter, foreign_key: 'user_id', class_name: 'User'

  def destroy_associtated_votes
    @idea_thread = self.idea_thread

    #This is bad but it will work for now!
    @ideas = @idea_thread.ideas


    votes = Vote.where(user_id: self.user_id)

    @ideas.each do |idea|
      destroy_vote = votes.where(idea_id: idea[:id])
      destroy_vote.each do |vote|
        vote.destroy
      end
    end
  end
end
