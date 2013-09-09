class VotesController < ApplicationController

  before_action :ensure_authenticated

  def create
    @vote = Vote.new(vote_params)
    if @vote.save
      conn = ActiveRecord::Base.connection.raw_connection
      conn.exec("NOTIFY \"channel\", \'id: #{@vote.to_json}\';")
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
      conn = ActiveRecord::Base.connection.raw_connection
      conn.exec("NOTIFY \"channel\", \'id: #{@idea.to_json}\';")
      render :show, status: :ok
    else
      render :json, status: :unprocessable_entity
    end
  end



  def destroy
    @vote = Vote.find(params[:id])
    if @vote.destroy
      conn = ActiveRecord::Base.connection.raw_connection
      conn.exec("NOTIFY \"channel\", \'id: #{params[:id]}\';")
      render :show, status: :ok
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
        end
      end
    rescue IOError
      # When the client disconnects, we'll get an IOError on write
    ensure
      sse.close
    end
  end

  private
    def vote_params
      params.require(:vote).permit(:idea_id, :user_id)
    end
end
