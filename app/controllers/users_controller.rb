class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      auto_login(@user)
      @logged_in = current_user == @user
      render :show, status: 201
    else
      render :json => @user.errors.full_messages, status: 422
    end

  end

  def show
    @user = User.find(params[:id])
    render :show, status: 200
  end

  private
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end

end
