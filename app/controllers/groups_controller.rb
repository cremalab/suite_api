class GroupsController < ApplicationController

  def create

  end

  def index
    @groups = Group.all
    render :index, status: :ok
  end

  def update

  end

  def destroy

  end

end
