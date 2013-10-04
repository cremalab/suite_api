class MembershipsController < ApplicationController
  before_action :ensure_authenticated
  before_action :ensure_group_ownership

  def destroy
    if @membership.destroy
      render :json => ['Membership destroyed'], status: :ok
    else
      render :show, status: :unprocessable_entity
    end
  end

private
  def ensure_group_ownership
    @membership = Membership.find(params[:id])
    @group = @membership.group
    unless @group.owner_id == current_auth_user.id
      head :unauthorized
    end
  end

end