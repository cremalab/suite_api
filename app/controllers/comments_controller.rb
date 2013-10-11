class CommentsController < ApplicationController

  before_action :get_comment, only: [:show, :update]
  before_action :get_comments, only: [:index]

  def index
    render :index, status: :ok
  end

  def create
    get_idea
    @comment = @idea.comments.new(comment_params)

    if @comment.save
      faye_publish("Comment", "/message/channel")
      render :show, status: 201
    else
      render :json => @idea_thread.errors.full_messages, status: 422
    end

  end

  def show
    @comment = Comment.find(params[:id])
    render :show, status: 200
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update_attributes(comment_params)
      faye_publish("Comment", "/message/channel")
      render :show, status: :ok
    else
      render :show, status: :unprocessable_entity
    end

  end

  def destroy
    id = params[:id]
    @comment = Comment.find(id)
    if @comment.destroy
      faye_destroy(id, "Comment", "/message/channel")
      render :json => ['Comment destroyed'], status: :ok
    else
      render :show, status: :unprocessable_entity
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:content, :user_id, :idea_id)

    end

    def get_comments
      if params[:idea_id]
        get_idea
        @comments = @idea.comments
      else
        @comments = Comment.all
      end
    end

    def get_idea
      @idea    = Idea.find(params[:idea_id])
    end

end
