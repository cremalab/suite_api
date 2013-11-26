# Public: This class generates access tokens for the user when he is logs in to
# the site.
#
# Example:
#
#
#
#
#
class SessionsController < ApplicationController

  def create
    @user = login(session_params[:email], session_params[:password], session_params[:remember_me])
    if @user
      @subscription = @user.subscription
      render json: @user, status: 200
    else
      render :json => ['Invalid email or password'], status: 401
    end
  end

  def destroy
    logout
    render :json => ['Logged out'], status: :ok
  end

  private

    def session_params
      params.require(:session).permit(:email, :password, :remember_me)
    end

end
