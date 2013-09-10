class VotingRightsController < ApplicationController
  before_action :ensure_authenticated

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
end
