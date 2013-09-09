class IdeaThreadsController < ApplicationController

  before_action :ensure_authenticated

  def index
    @idea_threads = IdeaThread.all
    render :index, status: :ok
  end
  def create
    @idea_thread = IdeaThread.new(idea_thread_params)
    if @idea_thread.save
      conn = ActiveRecord::Base.connection.raw_connection
      conn.exec("NOTIFY \"channel\";")
      render :show, status: 201
    else
      render :json => @idea_thread.errors.full_messages, status: 422
      p @idea_thread.errors.full_messages
    end
  end

  def destroy
    @idea_thread = IdeaThread.find(params[:id])
    if @idea_thread.destroy
      conn = ActiveRecord::Base.connection.raw_connection
      conn.exec("NOTIFY \"channel\";")
      render :json => ['Idea thread destroyed'], status: :ok
    else
      render :show, status: :unprocessable_entity
    end
  end

  def event
    sse = SSE.new(response)
    conn = ActiveRecord::Base.connection.raw_connection
    conn.exec("LISTEN \"channel\";")
    begin
      loop do
        conn.wait_for_notify do |event, pid, payload|
          logger.info event
          logger.info pid
          logger.info payload
          sse.write(payload)
        end
      end
    rescue IOError
      # When the client disconnects, we'll get an IOError on write
    ensure
      sse.close
    end
  end

private
  def idea_thread_params
    params.require(:idea_thread).permit(:user_id, ideas_attributes: [ :title, :when, :user_id, :description, votes_attributes: [ :user_id ] ])
  end
end
