# Public: This class generates access tokens for the user when he is logs in to
# the site.
#
# Example:
#
#
#
#
#
class GroupsController < ApplicationController

  before_action :ensure_authenticated

  def index
    @groups = Group.where(owner_id: current_auth_user.id)#current user
    render json: @groups
  end


  def create
    @group = Group.new(group_params)
    if @group.save
      render json: @group
    else
      render :json => @idea_thread.errors.full_messages, status: 422
    end
  end

  def show
    @group = Group.find(params[:id])
    render json: @group
  end

  def update
    @group = Group.find(params[:id])
    if @group.update_attributes(group_params)
      render json: @group
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
    params.require(:group).permit(:name,
                                  :owner_id,
                                  memberships_attributes:
                                    [:id, :user_id])
  end

end
