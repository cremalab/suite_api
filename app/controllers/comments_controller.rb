class CommentsController < ApplicationController
  def index
    @comments = Comment.all
    render :index, status: :ok

  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      render :show, status: 201
    else
      render :json => @idea_thread.errors.full_messages, status: 422
    end

  end

  def show

  end

  def update

  end

  def destroy

  end

  private
    def comment_params
      params.require(:comment).permit(:content, :user_id, :idea_id)

    end


end
