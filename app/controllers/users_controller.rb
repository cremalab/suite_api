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

  def create
    @user = User.new(user_params)
    if @user.save
      @user.generate_api_key
      @user.message
      render json: @user
    else
      render :json => @user.errors.full_messages, status: 422
    end

  end

  def index
    @users = User.all
    render json: @users
  end

  def show
    @user = User.find(params[:id])
    render json: @user
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)

      #Send to Faye
      @user.message
      render json: @user
    else
      render :json => @user.errors.full_messages, status: 422
    end
  end

  def me
    @user = User.find(params[:auth][:user_id])
    if @user
      render json: @user
    else
      return head :no_content
    end
  end

  private
    def user_params
      params.require(:user).permit(
        :email, :password, :password_confirmation, :notifications,
        profile_attributes: [:first_name, :last_name]
      )
    end

end
