# Public: This class generates access tokens for the user when he is logs in to
# the site.
#
# Example:
#
#
#
#
#
class IdeaThreadsController < ApplicationController

  before_action :ensure_authenticated

  def index
    if @current_auth_user
      @idea_threads = current_auth_user.idea_threads.status(:open)
    else
      @idea_threads = IdeaThread.status(:open)
    end
    render json: @idea_threads
  end

  def create
    @user = User.find(idea_thread_params[:user_id])
    @idea_thread = IdeaThread.new(idea_thread_params)

    if @idea_thread.save
      @idea_thread.expiration_check
      @idea_thread.message

      render json: @idea_thread
    else
      render :json => @idea_thread.errors.full_messages, status: 422
    end
  end

  def show
    @idea_thread = IdeaThread.find(params[:id])
    render json: @idea_thread
  end

  def update
    @idea_thread = IdeaThread.find(params[:id])
    if @idea_thread.update_attributes(update_params)
      @idea_thread.expiration_check
      @idea_thread.message
      render json: @idea_thread
    else
      render :show, status: :unprocessable_entity
    end
  end

  def destroy
    id = params[:id]
    @idea_thread = IdeaThread.find(id)
    @idea_thread.create_activity :destroy, owner: current_auth_user
    if @idea_thread.status == :open
      job = Delayed::Job.find_by(queue: id)
      if job
        job.delete
      end
    end
    @idea_thread.destroy
    @idea_thread.delete_message
    # Activity Feed
    render :json => ['Idea thread destroyed'], status: :ok
  end



private
  def idea_thread_params
    params.require(:idea_thread).permit(
      :title, :status, :user_id, :expiration, :description,
      ideas_attributes: [ :title, :user_id, :description,
        votes_attributes: [ :user_id ]
      ],
      voting_rights_attributes: [ :user_id ]
    )
  end

  def update_params
    params.require(:idea_thread).permit(
      :title, :status, :expiration, :description
    )
  end
end
