# Public: This class generates access tokens for the user when he is logs in to
# the site.
#
# Example:
#
#
#
#
#
class CommentsController < ApplicationController

  before_action :get_comments, only: [:index]

  def index
    render json: @comments
  end

  def create
    get_idea
    @comment = @idea.comments.new(comment_params)

    if @comment.save
      @comment.message
      render json: @comment
    else
      render :json => @comment.errors.full_messages, status: 422
    end

  end

  def show
    @comment = Comment.find(params[:id])
    render json: @comment
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update_attributes(comment_params)
      @comment.message
      render json: @comment
    else
      render :json => @comment.errors.full_messages, status: 422
    end

  end

  def destroy
    id = params[:id]
    @comment = Comment.find(id)
    @comment.delete_message
    render :json => ['Comment destroyed'], status: :ok
  end

  private
    def comment_params
      params.require(:comment).permit(:content, :user_id, :idea_id)
    end

    def get_comments
      if params[:idea_id]
        get_idea
        @comments = @idea.comments
      end
    end

    def get_idea
      @idea    = Idea.find(params[:idea_id])
    end



end
