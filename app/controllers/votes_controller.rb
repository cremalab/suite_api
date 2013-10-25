# Public: This class generates access tokens for the user when he is logs in to
# the site.
#
# Example:
#
#
#
#
#
class VotesController < ApplicationController

  before_action :ensure_authenticated

  def create
    @vote = Vote.new(vote_params)
    checker = UserVoteChecker.new

    if checker.create_vote(@vote)

      @vote.message

      render json: @vote, status: 201
    else
      render :json => @vote.errors.full_messages, status: 422
    end
  end

  def show
    @vote = Vote.find(params[:id])
    render json: @vote
  end

  def destroy
    @vote = Vote.find(params[:id])
    @vote.create_activity :destroy, owner: current_auth_user,
                                    recipient: @vote.idea
    if @vote.destroy
      render :json => ['Vote destroyed'], status: :ok
    else
      render :json => @voting_right.errors.full_messages, status: 422
    end
  end

  private
    def vote_params
      params.require(:vote).permit(:idea_id, :user_id)
    end
end
