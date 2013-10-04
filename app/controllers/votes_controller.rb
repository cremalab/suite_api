class VotesController < ApplicationController

  before_action :ensure_authenticated

  def create
    @vote = Vote.new(vote_params)
    checker = UserVoteChecker.new

    if checker.create_vote(@vote)

      faye_publish("Vote", "/message/channel")
      render :show, status: 201
    else
      render :json => @vote.errors.full_messages, status: 422
    end
  end

  def show
    @vote = Vote.find(params[:id])
    render :show, status: 200
  end

  def destroy
    @vote = Vote.find(params[:id])
    if @vote.destroy
      render :show, status: :ok
    else
      render :show, status: :unprocessable_entity
    end
  end

  private
    def vote_params
      params.require(:vote).permit(:idea_id, :user_id)
    end
end
