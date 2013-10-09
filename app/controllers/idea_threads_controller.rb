class IdeaThreadsController < ApplicationController

  before_action :ensure_authenticated

  def index
    if @current_auth_user
      @idea_threads = current_auth_user.idea_threads.status(:open)
    else
      @idea_threads = IdeaThread.status(:open)
    end
    render :index, status: :ok
  end

  def create
    user_id = idea_thread_params[:ideas_attributes][0]['user_id']
    @user = User.find(user_id)
    @idea_thread = IdeaThread.new(idea_thread_params)

    if @idea_thread.save
      expiration = @idea_thread.expiration
      if expiration != nil
        IdeaThread.delay(run_at: expiration).auto_archive(@idea_thread.id)
      end
      faye_publish("IdeaThread", "/message/channel")
      render :show, status: 201
    else
      render :json => @idea_thread.errors.full_messages, status: 422
    end
  end

  def show
    @idea_thread = IdeaThread.find(params[:id])
    render :show, status: 201
  end

  def update
    param_idea_thread = params[:idea_thread]
    @idea_thread = IdeaThread.find(params[:id])
    if @idea_thread.update_attributes(title: param_idea_thread[:title],
                                      status: param_idea_thread[:status])
      faye_publish("IdeaThread", "/message/channel")
      render :show, status: 201
    else
      render :show, status: :unprocessable_entity
    end
  end

  def destroy
    id = params[:id]
    @idea_thread = IdeaThread.find(id)
    if @idea_thread.status == :open
      #Destroy job in queue
    end
    if @idea_thread.destroy

      faye_destroy(id, "IdeaThread", "/message/channel")
      render :json => ['Idea thread destroyed'], status: :ok
    else
      render :show, status: :unprocessable_entity
    end
  end



private
  def idea_thread_params
    params.require(:idea_thread).permit(
      :title, :status, :user_id,
      ideas_attributes: [ :title, :when, :user_id, :description,
      votes_attributes: [ :user_id ] ],
      voting_rights_attributes: [ :user_id ]
    )
  end
end
