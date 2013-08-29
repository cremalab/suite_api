class SessionsController < ApplicationController

  def create
    @user = login(params[:email], params[:password], params[:remember_me])
    if @user
      @logged_in = current_user == @user
      render "users/show", status: 200
    else
      render :json => ['Invalid email or password'], status: 401
    end
  end

  def destroy
    logout
    render :json => ['Logged out'], status: :ok
  end
end
