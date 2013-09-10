require 'sse'

class IdeasController < ApplicationController
  include ActionController::Live

  before_action :ensure_authenticated

  def create
    @idea = Idea.new(idea_params)
    if @idea.save
      conn = ActiveRecord::Base.connection.raw_connection
      conn.exec("NOTIFY \"channel\", \'id: #{@idea.to_json}\';")
      render :show, status: 201
    else
      render :json => @idea.errors.full_messages, status: 422
    end
  end

  def index
    @ideas = Idea.all
    render :index, status: :ok
  end

  def show
    @idea = Idea.find(params[:id])
    render :show, status: 200
  end

  def update
    @idea = Idea.find(params[:id])
    if @idea.update_attributes(idea_params)
      conn = ActiveRecord::Base.connection.raw_connection
      conn.exec("NOTIFY \"channel\", \'id: #{@idea.to_json}\';")
      @idea.votes.destroy_all if params[:idea][:edited]
      render :show, status: :ok
    else
      render :show, status: :unprocessable_entity
    end
  end

  def destroy
      @idea = Idea.find(params[:id])
      if @idea.destroy
        conn.exec("NOTIFY \"channel\", \'id: #{params[:id]}\';")
        render :json => ['Idea destroyed'], status: :ok
      else
        render :show, status: :unprocessable_entity
      end
  end

  private
    def idea_params
      params.require(:idea).permit(:title, :when, :user_id, :idea_thread_id ,:description, votes_attributes: [ :user_id ])
    end
end
