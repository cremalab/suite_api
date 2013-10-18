# Public: This class generates access tokens for the user when he is logs in to
# the site.
#
# Example:
#
#
#
#
#
class IdeasController < ApplicationController

  before_action :ensure_authenticated

  def index
    @ideas = Idea.all
    render json: @ideas
  end

  def create
    @idea = Idea.new(idea_params)
    if @idea.save
      @idea.create_associated_vote

      @idea.message
      render json: @idea
    else
      render :json => @idea.errors.full_messages, status: 422
    end
  end

  def show
    @idea = Idea.find(params[:id])
    render json: @idea
  end

  def update
    @idea = Idea.find(params[:id])
    if @idea.update_attributes(idea_params)
      @idea.message
      @idea.votes.destroy_all if params[:idea][:edited]
      render json: @idea
    else
      render :json => @idea.errors.full_messages, status: 422
    end
  end

  def destroy
    id = params[:id]
    @idea = Idea.find(id)
    if @idea.destroy
      @idea.delete_message
      render :json => ['Idea destroyed'], status: :ok
    else
      render :json => @idea.errors.full_messages, status: 422
    end
  end

  private
    def idea_params
      params.require(:idea).permit( :title,
                                    :user_id,
                                    :idea_thread_id,
                                    :description)
    end
end
