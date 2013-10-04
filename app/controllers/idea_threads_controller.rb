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
      #Send to Faye
      @idea_thread_json = render_to_string(template: @SHOW_VIEW)
      PrivatePub.publish_to("/message/channel", message: @idea_thread_json)

      render :show, status: 201
    else
      render :json => @idea_thread.errors.full_messages, status: 422
    end
  end

  def destroy
    @idea_thread = IdeaThread.find(params[:id])
    if @idea_thread.destroy
      #Send to Faye
      delete_json = '{\"model_name\": \"IdeaThread\", \"deleted\": true,' +
                    ' \"id\": #{params[:id]}}'
      PrivatePub.publish_to("/message/channel", message: delete_json)

      render :json => ['Idea thread destroyed'], status: :ok
    else
      render :show, status: :unprocessable_entity
    end
  end

  def show
    @idea_thread = IdeaThread.find(params[:id])
    render :show, status: 201
  end

  def update
    @idea_thread = IdeaThread.find(params[:id])
    if @idea_thread.update_attributes(title: params[:idea_thread][:title],
                                      status: params[:idea_thread][:status])
      @idea_thread_json = render_to_string(template: @SHOW_VIEW)
      PrivatePub.publish_to("/message/channel", message: @idea_thread_json)
      render :show, status: 201
    else
      render :show, status: :unprocessable_entity
    end
  end

private
  @SHOW_VIEW = 'idea_threads/show.jbuilder'
  def idea_thread_params
    params.require(:idea_thread).permit(
      :title, :status, :user_id,
      ideas_attributes: [ :title, :when, :user_id, :description,
      votes_attributes: [ :user_id ] ],
      voting_rights_attributes: [ :user_id ]
    )
  end
end
