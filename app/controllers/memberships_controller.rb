# Public: This class generates access tokens for the user when he is logs in to
# the site.
#
# Example:
#
#
#
#
#
class MembershipsController < ApplicationController
  before_action :ensure_authenticated
  before_action :ensure_group_ownership

  def destroy
    if @membership.destroy
      render :json => ['Membership destroyed'], status: :ok
    else
      render :json => @membership.errors.full_messages, status: 422
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