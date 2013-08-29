class UsersController < ApplicationController

  # before_action :ensure_authenticated, except: [:create]

  def create
    @user = User.new(user_params)

    if @user.save

      # May want to refactor this
      if @user.api_keys.length > 0
        @user.api_keys.last.destroy
      end

      @api_key = @user.api_keys.create()

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

  def me
    @user = current_user
    if @user
      render :show, status: 200
    else
      return head :no_content
    end
  end

  private
    def user_params
      params.permit(:email, :password, :password_confirmation)
    end

end
