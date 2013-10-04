class UsersController < ApplicationController

  before_action :ensure_authenticated, except: [:create]

  def create
    @user = User.new(user_params)
    @user.build_profile

    if @user.save

      @user.generate_api_key
      auto_login(@user)
      @logged_in = current_user == @user


      #Send to Faye
      @user_json = render_to_string(template: 'users/show.jbuilder')
      PrivatePub.publish_to("/message/channel", message: @user_json)

      render :show, status: 201
    else
      render :json => @user.errors.full_messages, status: 422
    end

  end

  def index
    @users = User.all
    render :index, status: :ok
  end

  def show
    @user = User.find(params[:id])
    render :show, status: 200
  end

  def update
    @user = User.find(params[:id])
    @logged_in = true
    if @user.profile.nil?
      @user.build_profile
    end
    if @user.update_attributes(user_params)

      #Send to Faye
      @user_json = render_to_string(template: 'users/show.jbuilder')
      PrivatePub.publish_to("/message/channel", message: @user_json)

      render :show, status: :ok
    else
      render :json => @user.errors.full_messages, status: 422
    end
  end

  def me
    @user = User.find(params[:auth][:user_id])
    if @user
      @logged_in = true
      render :show, status: 200
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
