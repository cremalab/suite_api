class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :null_session

  before_action :get_header_info

  def current_auth_user
    return @current_auth_user
  end

  private

    def get_header_info
      @access_token = request.headers['HTTP_X_ACCESS_TOKEN']
      @user_id      = request.headers['HTTP_X_USER_ID']
    end

    def ensure_authenticated

      if is_xhr?
        if @access_token && @user_id
          api_key = ApiKey.find_by(
            access_token: @access_token,
            user_id: @user_id
          )
          if api_key
            @current_auth_user = api_key.user
          else
            head :unauthorized unless api_key
          end
        else
          head :unauthorized
        end
      end
    end

    def is_xhr?
      return true if request.headers['HTTP_X_REQUESTED_WITH']
    end
end
