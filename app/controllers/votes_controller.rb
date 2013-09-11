require 'notifier'

class VotesController < ApplicationController

  before_action :ensure_authenticated

  def create
    @vote = Vote.new(vote_params)
    if @vote.save
      #Send to PostgreSQL
      @vote_json = render_to_string(template: 'votes/show.jbuilder')
      @vote_json = Notifier.new(@vote_json, "Vote")
      Vote.connection.raw_connection.exec("NOTIFY \"channel\", #{@vote_json.payload};")
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
      #Send to PostgreSQL
      @vote_json = render_to_string(template: 'votes/show.jbuilder')
      @vote_json = Notifier.new(@vote_json, "Vote")
      Vote.connection.raw_connection.exec("NOTIFY \"channel\", #{@vote_json.payload};")

      render :show, status: :ok
    else
      render :json, status: :unprocessable_entity
    end
  end



  def destroy
    @vote = Vote.find(params[:id])
    if @vote.destroy
      #Send to PostgreSQL
      #conn = ActiveRecord::Base.connection.raw_connection
      Vote.connection.raw_connection.exec("NOTIFY \"channel\", \'id: #{params[:id]}\';")
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
