class GroupsController < ApplicationController

  def index
    @groups = Group.all
    render :index, status: :ok
  end


  def create
    @group = Group.new(group_params)
    if @group.save
      render :show, status: 201
    else
      render :json => @idea_thread.errors.full_messages, status: 422
    end
  end

  def show
    @group = Group.find(params[:id])
    render :show, status: 200
  end

  def update
    @group = Group.find(params[:id])
    if @group.update_attributes(group_params)
       render :show, status: :ok
    else
      render :show, status: :unprocessable_entity
    end
  end

  def destroy
    @group = Group.find(params[:id])
    if @group.destroy
      render :json => ['Group destroyed'], status: :ok
    else
      render :show, status: :unprocessable_entity
    end
  end

private
  def group_params
    params.require(:group).permit(:name, :owner_id, memberships_attributes: [:id, :user_id])
  end

end
