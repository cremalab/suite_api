# Public: This class generates access tokens for the user when he is logs in to
# the site.
#
# Example:
#
#
#
#
#
class UsersController < ApplicationController

  before_action :ensure_authenticated, except: [:create]

 def index
    @users = User.all
    render json: @users
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.generate_api_key
      render json: @user
    else
      render :json => @user.errors.full_messages, status: 422
    end

  end

  def show
    @user = User.find(params[:id])
    render json: @user
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)

      #Send to Faye
      render json: @user
    else
      render :json => @user.errors.full_messages, status: 422
    end
  end

  def me
    @user = User.find(params[:auth][:user_id])
    render json: @user
  end

  private
    def user_params
      params.require(:user).permit(
        :email, :password, :password_confirmation, :notifications,
        profile_attributes: [:first_name, :last_name],
        notification_setting_attributes: [:vote, :idea, :idea_thread, :sound]
      )
    end

end
