class IdeaThreadsController < ApplicationController

  before_action :ensure_authenticated

  def index
    @idea_threads = IdeaThread.all
    render :index, status: :ok
  end
  def create
    @idea_thread = IdeaThread.new(idea_thread_params)
    if @idea_thread.save
      render :show, status: 201
    else
      render :json => @idea_thread.errors.full_messages, status: 422
      p @idea_thread.errors.full_messages
    end
  end

  def destroy
    @idea_thread = IdeaThread.find(params[:id])
    if @idea_thread.destroy
      render :json => ['Idea thread destroyed'], status: :ok
    else
      render :show, status: :unprocessable_entity
    end
  end

private
  def idea_thread_params
    params.require(:idea_thread).permit(:user_id, ideas_attributes: [ :title, :when, :user_id, :description, votes_attributes: [ :user_id ] ])
  end
end
