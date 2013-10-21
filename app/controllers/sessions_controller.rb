class SessionsController < ApplicationController

  def create
    @user = login(params[:email], params[:password], params[:remember_me])
    if @user
      @subscription = PrivatePub.subscription(:channel => '/message/channel')
      @subscription['signature'] = ''
      @logged_in = current_user == @user
      render json: @user, status: 200
    else
      render :json => ['Invalid email or password'], status: 401
    end
  end

  def destroy
    logout
    render :json => ['Logged out'], status: :ok
  end
end
