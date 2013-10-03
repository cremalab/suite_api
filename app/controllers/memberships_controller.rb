class MembershipsController < ApplicationController

  def destroy
    @membership = Membership.find(params[:id])
    if @membership.destroy
      render :json => ['Membership destroyed'], status: :ok
    else
      render :show, status: :unprocessable_entity
    end
  end

end
