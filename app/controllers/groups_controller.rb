class GroupsController < ApplicationController

  def index
    @groups = Group.all
    render :index, status: :ok
  end


  def create
    @group = Group.new(group_params)
    p @group
    if @group.save
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
  def group_params
    params.require(:group).permit(:name, memberships_attributes: [:user_id])

  end

end
