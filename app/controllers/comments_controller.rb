class CommentsController < ApplicationController
  def index
    @comments = Comment.all
    render :index, status: :ok

  end

  def create

  end

  def show

  end

  def update

  end

  def destroy

  end


end
