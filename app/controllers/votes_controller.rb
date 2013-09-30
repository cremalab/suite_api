class VotesController < ApplicationController

  before_action :ensure_authenticated

  def create
    idea         = Idea.find(vote_params[:idea_id])
    idea_thread  = idea.idea_thread
    user         = User.find(vote_params[:user_id])

    @vote = Vote.new(vote_params)
    checker = UserVoteChecker.new

    if checker.create_vote(@vote)
      #Send to Faye
      @vote_json = render_to_string(template: 'votes/full.jbuilder')
      PrivatePub.publish_to("/message/channel", message: @vote_json)

      render :show, status: 201
    else
      render :json => @vote.errors.full_messages, status: 422
    end
  end
  def show
    @vote = Vote.find(params[:id])
    render :show, status: 200
  end

  def update
    @vote = Vote.find(params[:id])
    if @vote.update_attributes(vote_params)

      #Send to Faye
      @vote_json = render_to_string(template: 'votes/full.jbuilder')
      # PrivatePub.publish_to("/message/channel", message: @vote_json)

      render :show, status: :ok
    else
      render :json, status: :unprocessable_entity
    end
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
