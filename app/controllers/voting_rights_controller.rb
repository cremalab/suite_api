class VotingRightsController < ApplicationController
  before_action :ensure_authenticated

  def create
    @voting_right = VotingRight.new(voting_right_params)
    if @voting_right.save
      render :show, status: :ok
    else
      render :json => @voting_right.errors.full_messages, status: 422
    end
  end

  def destroy
    @voting_right = VotingRight.find(params[:id])
    if @voting_right.destroy
      render :json => ['Voting Right destroyed'], status: :ok
    else
      render :show, status: :unprocessable_entity
    end
  end

  def show
    @voting_right = VotingRight.find(params[:id])
    render :show, status: :ok
  end

private
  def voting_right_params
    params.require(:voting_right).permit(:idea_thread_id, :user_id)
  end

end
