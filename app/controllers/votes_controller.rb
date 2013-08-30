class VotesController < ApplicationController
  def create
    @vote = Vote.new(vote_params)
    if @vote.save
      render :index, status: 201
    else
      render :json => @vote.errors.full_messages, status: 422
    end
  end
  def show
    @vote = Vote.find(params[:id])
    render :index, status: 200
  end

  def update
    @vote = Vote.find(params[:id])
    if @vote.update_attributes(vote_params)
      render :index, status: :ok
    else
      render :json, status: :unprocessable_entity
    end
  end

  def destroy
    @vote = Vote.find(params[:id])
    if @vote.destroy
      render :index, status: :ok
    else
      render :index, status: :unprocessable_entity
    end

  end

  private
    def vote_params
      params.require(:vote).permit(:idea_id, :user_id)
    end
end
