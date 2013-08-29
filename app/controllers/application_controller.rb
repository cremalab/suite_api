class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :null_session
  private
    def ensure_authenticated
      user = User.find(params[:auth][:user_id])
      api_key = ApiKey.where(
        access_token: params[:auth][:access_token],
        user_id: params[:auth][:access_token]
      )
      head :unauthorized unless api_key
    end
end
