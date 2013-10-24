# Public: This class generates access tokens for the user when he is logs in to
# the site.
#
# Example:
#
#
#
#
#
class VotingRightsController < ApplicationController
  before_action :ensure_authenticated

  def create
    @voting_right = VotingRight.new(voting_right_params)
    if @voting_right.save
      @idea_thread = @voting_right.idea_thread
      #Send to Faye
      @idea_thread.message


      render json: @voting_right, status: :ok
    else
      render :json => @voting_right.errors.full_messages, status: 422
    end
  end

  def show
    @voting_right = VotingRight.find(params[:id])
    render json: @voting_right
  end

  def destroy

    @voting_right = VotingRight.find(params[:id])
    if @voting_right.destroy
      @voting_right.destroy_associtated_votes

      @idea_thread = @voting_right.idea_thread
      @idea_thread.delete_message
      render :json => ['Voting Right destroyed'], status: :ok
    else
      render :json => @voting_right.errors.full_messages, status: 422
    end
  end



private
  def voting_right_params
    params.require(:voting_right).permit(:idea_thread_id, :user_id)
  end

end
