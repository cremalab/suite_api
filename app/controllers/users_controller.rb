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
      conn = ActiveRecord::Base.connection.raw_connection
      conn.exec("NOTIFY \"channel\", \'#{@user}\';")
      render :show, status: 201
    else
      render :json => @user.errors.full_messages, status: 422
    end

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
      conn = ActiveRecord::Base.connection.raw_connection
      conn.exec("NOTIFY \"channel\", \'#{@user}\';")
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

   def event
    sse = SSE.new(response)
    conn = ActiveRecord::Base.connection.raw_connection
    conn.exec("LISTEN \"channel\";")
    begin
      loop do
        conn.wait_for_notify do |event, pid, payload|
          logger.info event
          logger.info pid
          logger.info payload
          sse.write(payload)
        end
      end
    rescue IOError
      # When the client disconnects, we'll get an IOError on write
    ensure
      sse.close
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
