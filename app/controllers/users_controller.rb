require 'notifier'

class UsersController < ApplicationController

  before_action :ensure_authenticated, except: [:create]

  def create
    @user = User.new(user_params)
    @user.build_profile

    if @user.save

      # May want to refactor this
      if @user.api_keys.length > 0
        @user.api_keys.last.destroy
      end

      @api_key = @user.api_keys.create()

      auto_login(@user)
      @logged_in = current_user == @user
      #Send to PostgreSQL
      @user_json = render_to_string(template: 'users/show.jbuilder')
      @user_json = Notifier.new(@user_json, "User")
      User.connection.raw_connection.exec("NOTIFY \"channel\", #{@user_json.payload};")
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
    if @user.profile.nil?
      @user.build_profile
    end
    if @user.update_attributes(user_params)
      Send to PostgreSQL
      @user_json = render_to_string(template: 'ideas/show.jbuilder')
      @user_json = Notifier.new(@user_json, "User")
      User.connection.raw_connection.exec("NOTIFY \"channel\", #{@user_json.payload};")

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
        :email, :password, :password_confirmation,
        profile_attributes: [:first_name, :last_name]
      )
    end

end
