# application_controller.rb
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :null_session

  before_action :get_header_info

  def current_auth_user
    return @current_auth_user
  end

  private
    # Pre: None
    # Post: A formatted message should be pushed to the faye server.
    def faye_publish(model_name, channel)
      model_name = model_name.underscore.pluralize
      if model_name == "votes"
        @json = render_to_string(template: "/#{model_name}/full.jbuilder")
      else
        @json = render_to_string(template: "/#{model_name}/show.jbuilder")
      end
      PrivatePub.publish_to(channel, message: @json)
    end

    # Pre: Must have the id of the deleted item
    # Post: A formatted message should be pushed to the faye server.
    def faye_destroy(id, model_name, channel)
      klass = model_name.constantize
      @model = klass.new(id: id)
      @json = render_to_string(template: "deleted.jbuilder")
      PrivatePub.publish_to(channel, message: @json)
    end

    def get_header_info
      headers = request.headers
      @access_token = headers['HTTP_X_ACCESS_TOKEN']
      @user_id      = headers['HTTP_X_USER_ID']
    end

    # Pre:
    # Post:
    def ensure_authenticated
      if is_xhr?
        if @access_token && @user_id
          api_key = ApiKey.find_by( access_token: @access_token,
                                    user_id: @user_id)
        end
        if api_key
          @current_auth_user = api_key.user
        else
          head :unauthorized
        end
      end
    end

    def is_xhr?
      return true if request.headers['HTTP_X_REQUESTED_WITH']
    end
end
