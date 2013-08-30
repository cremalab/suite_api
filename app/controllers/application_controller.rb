class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :null_session

  private

    def ensure_authenticated
      access_token = request.headers['HTTP_X_ACCESS_TOKEN']
      user_id      = request.headers['HTTP_X_USER_ID']
      if access_token && user_id
        api_key = ApiKey.where(
          access_token: access_token,
          user_id: user_id
        )
        if api_key
          current_user = access_token
        else
          head :unauthorized unless api_key
        end
      else
        head :unauthorized
      end
    end
end
