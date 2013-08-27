class SessionsController < ApplicationController
  def create
    @user = login(params[:email], params[:password], params[:remember_me])
    if @user
      render "users/show", status: 200
    else
      render :json => {message: "Email or password was invalid."}, status: 422
    end
  end

  def destroy
    logout
    render :json => {message: "Logged out"}, status: :ok
  end
end
