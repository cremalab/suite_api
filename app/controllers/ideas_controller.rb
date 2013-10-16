###############################################################################
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

      #faye_publish("Idea", "/message/channel")
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
      #faye_publish("Idea", "/message/channel")

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
      #faye_destroy(id, "Idea", "/message/channel")
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
